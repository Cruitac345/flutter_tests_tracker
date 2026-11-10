import 'package:test/test.dart';
import 'package:aurora_report_example/report_service.dart';

void main() {
  final expenses = [
    Expense(date: DateTime(2026, 11, 2, 23, 59), category: 'Еда',
        amountKopecks: 10050, note: 'Кофе; булка'),
    Expense(date: DateTime(2026, 11, 3), category: 'Еда',
        amountKopecks: 2999, note: 'Обед'),
    Expense(date: DateTime(2026, 10, 31), category: 'Такси',
        amountKopecks: 50000),
  ];
  test('фильтрация по дням, включая 23:59', () {
    final selected = filterExpenses(expenses, DateTime(2026, 11, 2),
        DateTime(2026, 11, 2));
    expect(selected.length, 1);
  });
  test('сумма и группы', () {
    final selected = filterExpenses(expenses, DateTime(2026, 11, 1),
        DateTime(2026, 11, 30));
    expect(totalAmount(selected), 13049);
    expect(categoryTotals(selected)['Еда'], 13049);
  });
  test('csv round-trip: кавычки и разделители', () {
    final selected = expenses.sublist(0, 2);
    final csvText = buildDetailsCsv(selected);
    final parsed = parseDetailsCsv(csvText);
    expect(parsed.length, 2);
    expect(parsed.first.note, 'Кофе; булка');
    expect(parsed.first.amountKopecks, 10050);
  });
  test('неверная дата периода', () {
    expect(() => filterExpenses(expenses, DateTime(2026, 11, 3),
        DateTime(2026, 11, 1)), throwsArgumentError);
  });
}
