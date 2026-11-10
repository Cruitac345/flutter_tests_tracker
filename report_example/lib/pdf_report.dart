import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'report_service.dart';

/// Передай TTF с кириллицей из assets (или локального файла).
Future<File> createPdfReport({
  required List<Expense> expenses,
  required Uint8List ttfBytes,
  required File outputFile,
}) async {
  final font = pw.Font.ttf(ByteData.sublistView(ttfBytes));
  final doc = pw.Document();
  doc.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    theme: pw.ThemeData.withFont(base: font, bold: font),
    build: (context) => [
      pw.Text('Отчёт по расходам', style: pw.TextStyle(font: font, fontSize: 20)),
      pw.SizedBox(height: 12),
      pw.Text('Количество операций: ${expenses.length}'),
      pw.Text('Итого: ${rubles(totalAmount(expenses))} руб.'),
      pw.SizedBox(height: 12),
      pw.Table.fromTextArray(
        headers: ['Дата', 'Категория', 'Сумма', 'Примечание'],
        data: [
          for (final e in expenses)
            [dateString(e.date), e.category, rubles(e.amountKopecks), e.note],
        ],
        headerStyle: pw.TextStyle(font: font),
        cellStyle: pw.TextStyle(font: font),
      ),
      pw.SizedBox(height: 12),
      pw.Text('По категориям:', style: pw.TextStyle(font: font, fontSize: 14)),
      for (final item in categoryTotals(expenses).entries)
        pw.Text('${item.key}: ${rubles(item.value)} руб.'),
    ],
  ));
  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsBytes(await doc.save());
  return outputFile;
}
