import 'dart:io';
import 'package:aurora_report_example/report_service.dart';

Future<void> main() async {
  final expenses = [
    Expense(date: DateTime(2026, 11, 1), category: 'Еда',
        amountKopecks: 35050, note: 'Кофе; обед'),
    Expense(date: DateTime(2026, 11, 2, 23, 59), category: 'Транспорт',
        amountKopecks: 7990, note: 'Такси «Дом, работа»'),
    Expense(date: DateTime(2026, 11, 3), category: 'Еда',
        amountKopecks: 12000, note: 'Покупки'),
    Expense(date: DateTime(2026, 10, 28), category: 'Еда',
        amountKopecks: 5000, note: 'Не включать в ноябрь'),
  ];
  final selected = filterExpenses(
      expenses, DateTime(2026, 11, 1), DateTime(2026, 11, 30));
  final output = Directory('output');
  final details = await saveCsv(output, 'report.csv', buildDetailsCsv(selected));
  final summary = await saveCsv(output, 'summary.csv', buildSummaryCsv(selected));
  print('Записано: ${selected.length} операций');
  print('Итого: ${rubles(totalAmount(selected))} руб.');
  print('Отчёт: ${details.path}');
  print('По категориям: ${summary.path}');
}
