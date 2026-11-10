import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

/// Сумму храним в копейках, чтобы не терять точность.
class Expense {
  final DateTime date;
  final String category;
  final int amountKopecks;
  final String note;

  const Expense({
    required this.date,
    required this.category,
    required this.amountKopecks,
    this.note = '',
  });
}

String dateString(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

String rubles(int kopecks) {
  final sign = kopecks < 0 ? '-' : '';
  final abs = kopecks.abs();
  return '$sign${abs ~/ 100}.${(abs % 100).toString().padLeft(2, '0')}';
}

/// Включает обе крайние даты, даже если время записи 23:59.
List<Expense> filterExpenses(
  List<Expense> expenses, DateTime from, DateTime to,
) {
  final start = DateTime(from.year, from.month, from.day);
  final end = DateTime(to.year, to.month, to.day);
  if (start.isAfter(end)) throw ArgumentError('Дата начала позже конца');
  return expenses.where((e) {
    final day = DateTime(e.date.year, e.date.month, e.date.day);
    return !day.isBefore(start) && !day.isAfter(end);
  }).toList()..sort((a, b) => a.date.compareTo(b.date));
}

int totalAmount(Iterable<Expense> expenses) =>
    expenses.fold(0, (sum, e) => sum + e.amountKopecks);

Map<String, int> categoryTotals(Iterable<Expense> expenses) {
  final result = <String, int>{};
  for (final expense in expenses) {
    result.update(expense.category,
        (sum) => sum + expense.amountKopecks,
        ifAbsent: () => expense.amountKopecks);
  }
  return Map.fromEntries(result.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key)));
}

/// Настоящий CSV через пакет csv 8.x, не через join(',').
String buildDetailsCsv(List<Expense> expenses) {
  final rows = <List<dynamic>>[
    ['Дата', 'Категория', 'Сумма (руб.)', 'Комментарий'],
    for (final e in expenses)
      [dateString(e.date), e.category, rubles(e.amountKopecks), e.note],
    ['ИТОГО', '', rubles(totalAmount(expenses)), ''],
  ];
  return Csv(fieldDelimiter: ';', lineDelimiter: '\r\n').encode(rows);
}

String buildSummaryCsv(List<Expense> expenses) {
  final rows = <List<dynamic>>[
    ['Категория', 'Сумма (руб.)'],
    for (final item in categoryTotals(expenses).entries)
      [item.key, rubles(item.value)],
    ['ИТОГО', rubles(totalAmount(expenses))],
  ];
  return Csv(fieldDelimiter: ';', lineDelimiter: '\r\n').encode(rows);
}

/// Экспорт в UTF-8 BOM для удобства Excel. directory — существующий каталог.
Future<File> saveCsv(Directory directory, String name, String data) async {
  await directory.create(recursive: true);
  final file = File('${directory.path}${Platform.pathSeparator}$name');
  await file.writeAsBytes([0xEF, 0xBB, 0xBF, ...utf8.encode(data)]);
  return file;
}

/// Импорт CSV с заголовком; строку ИТОГО не импортируем.
List<Expense> parseDetailsCsv(String data) {
  final cleaned = data.replaceFirst('\uFEFF', '');
  final rows = Csv(fieldDelimiter: ';').decode(cleaned);
  if (rows.isEmpty || rows.first.length < 4 ||
      rows.first[0] != 'Дата' || rows.first[1] != 'Категория') {
    throw const FormatException('Неверный заголовок CSV');
  }
  final result = <Expense>[];
  for (final row in rows.skip(1)) {
    if (row.isEmpty || row[0].toString() == 'ИТОГО') continue;
    if (row.length < 4) throw const FormatException('Недостаточно колонок');
    final date = DateTime.tryParse(row[0].toString());
    final money = row[2].toString().replaceAll(',', '.');
    final match = RegExp(r'^(-?)(\d+)\.(\d{2})$').firstMatch(money);
    if (date == null || match == null) {
      throw FormatException('Ошибка даты или суммы: $row');
    }
    final value = int.parse(match.group(2)!) * 100 + int.parse(match.group(3)!);
    result.add(Expense(
      date: date,
      category: row[1].toString(),
      amountKopecks: match.group(1) == '-' ? -value : value,
      note: row[3].toString(),
    ));
  }
  return result;
}
