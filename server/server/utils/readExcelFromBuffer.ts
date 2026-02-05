import * as ExcelJS from 'exceljs';

/**
 * 获取单元格的文本值
 * @param cell Excel单元格对象
 * @returns 单元格的文本值
 */
function getCellTextValue(cell: ExcelJS.Cell): string {
  // 如果单元格为空，返回空字符串
  if (!cell.value) {
    return '';
  }

  // 处理不同类型的单元格值
  switch (typeof cell.value) {
    case 'string':
    case 'number':
    case 'boolean':
      // 直接返回基本类型的值转字符串
      return String(cell.value);

    case 'object':
      // 处理对象类型的值
      if (cell.value === null) {
        return '';
      }

      // 处理富文本对象
      if ('richText' in cell.value && Array.isArray(cell.value.richText)) {
        return cell.value.richText.map((text: any) => text.text || '').join('');
      }

      // 处理公式结果对象
      if ('result' in cell.value) {
        return String(cell.value.result || '');
      }

      // 处理公式对象
      if ('formula' in cell.value) {
        return String(cell.value.formula || '');
      }

      // 处理日期对象
      if (cell.value instanceof Date) {
        return cell.value.toISOString().split('T')[0];
      }

      // 处理其他对象类型，尝试使用text属性
      if ('text' in cell.value) {
        return String(cell.value.text || '');
      }

      // 最后尝试toString
      try {
        return String(cell.value);
      } catch {
        return '';
      }

    default:
      return '';
  }
}

export async function readExcelFromBuffer(fileBuffer: ExcelJS.Buffer, sheetName?: string) {
  try {
    const workbook = new (ExcelJS as any).default.Workbook();
    // 使用buffer数据加载工作簿
    await workbook.xlsx.load(fileBuffer);

    let worksheet;

    if (sheetName) {
      // 尝试获取指定名称的工作表
      worksheet = workbook.getWorksheet(sheetName);

      // 如果指定的工作表不存在，使用第一个工作表
      if (!worksheet) {
        worksheet = workbook.getWorksheet(1);
        console.warn(`工作表 "${sheetName}" 不存在，已使用第一个工作表`);
      }
    } else {
      // 如果没有指定工作表名称，使用第一个工作表
      worksheet = workbook.getWorksheet(1);
    }

    if (!worksheet) {
      throw new Error('Excel文件中没有找到工作表');
    }

    const jsonData: any[] = [];
    let headers: string[] = [];

    worksheet.eachRow({ includeEmpty: false }, (row: ExcelJS.Row, rowNumber: number) => {
      if (rowNumber === 1) {
        // 处理表头，将表头保存为键名
        // row.values 是一个数组，索引从1开始
        headers = Array.from({ length: row.cellCount }, (_, i) => {
          const cell = row.getCell(i + 1);
          return getCellTextValue(cell) || `列${i + 1}`;
        });
      } else {
        const rowData: { [key: string]: string } = {};

        // 遍历行中的每个单元格
        row.eachCell((cell: ExcelJS.Cell, colNumber: number) => {
          const headerName = headers[colNumber - 1] || `列${colNumber}`;
          rowData[headerName] = getCellTextValue(cell);
        });

        // 确保所有列都有值，即使是空的
        for (let i = 0; i < headers.length; i++) {
          const headerName = headers[i];
          if (!(headerName in rowData)) {
            rowData[headerName] = '';
          }
        }

        jsonData.push(rowData);
      }
    });

    return jsonData;
  } catch (error) {
    throw createError({ statusCode: 400, message: `读取Excel文件失败: ${String(error)}` });
  }
}
