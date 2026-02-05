export interface ApiResponse<T> {
  code: number;
  message: string;
  data: T;
}

// 函数重载声明
export function createApiResponse<T>(data: T): ApiResponse<T>;
export function createApiResponse<T>(data: T, code: number): ApiResponse<T>;
export function createApiResponse<T>(data: T, code: number, message: string): ApiResponse<T>;

// 函数实现
export function createApiResponse<T>(data: T, code?: number, message?: string): ApiResponse<T> {
  const defaultCode = 200;
  const defaultMessage = '成功';
  if (code === undefined && message === undefined) {
    return {
      code: defaultCode,
      message: defaultMessage,
      data
    };
  }
  return {
    code: code as number,
    message: message as string,
    data
  };
}
