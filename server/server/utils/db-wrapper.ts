import type { SelectQueryBuilder } from 'drizzle-orm/mysql-core';

// Database query wrapper with retry logic
export async function dbQuery<T>(queryFn: () => Promise<T>, maxRetries: number = 3, delay: number = 1000): Promise<T> {
  let lastError: Error | null = null;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      const result = await queryFn();
      return result;
    } catch (error: any) {
      lastError = error;

      // Check if it's a connection error
      const isConnectionError =
        error.cause?.message?.includes('connection') ||
        error.cause?.message?.includes('closed state') ||
        error.code === 'PROTOCOL_CONNECTION_LOST' ||
        error.code === 'ECONNRESET' ||
        error.code === 'ETIMEDOUT';

      if (isConnectionError && attempt < maxRetries) {
        console.warn(`Database connection error (attempt ${attempt}/${maxRetries}), retrying...`);
        await new Promise(resolve => setTimeout(resolve, delay * attempt));
        continue;
      }

      // For non-connection errors or last attempt, throw immediately
      throw error;
    }
  }

  throw lastError;
}

// Helper function to execute drizzle queries with retry
export function executeQuery<T>(queryBuilder: SelectQueryBuilder<any, any, any>): Promise<T[]> {
  return dbQuery(() => queryBuilder.execute() as Promise<T[]>);
}

// Helper function to execute first row query with retry
export function executeFirst<T>(queryBuilder: SelectQueryBuilder<any, any, any>): Promise<T | undefined> {
  return dbQuery(() => queryBuilder.limit(1).get() as Promise<T | undefined>);
}
