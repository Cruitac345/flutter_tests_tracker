# ⭐ НАЧНИ ЗДЕСЬ: ОТЧЁТ + CSV НА ПАКЕТЕ

Главный тренировочный сценарий: **отобрать расходы за период → посчитать итог → сгруппировать по категориям → выгрузить CSV → при необходимости PDF**.

1. [Пошаговое решение](REPORT_01_ГОТОВОЕ_РЕШЕНИЕ.md).
2. [CSV-сервис](report_example/lib/report_service.dart) — `package:csv`.
3. [Запуск консольного примера](report_example/bin/main.dart).
4. [PDF](report_example/lib/pdf_report.dart) — `package:pdf`.
5. [Тренировочные задания](practice/REPORT_TASKS.md).

```bash
cd report_example
dart pub get
dart run bin/main.dart
dart test
```

Для ExpenseTracker нужно сопоставить модель `Expense` с существующей моделью расходов. PDF требует TTF-шрифта с кириллицей. На Авроре путь сохранения и платформенные плагины проверяются отдельно.

**Это тренировка возможных задач, а не подтверждённое задание финала 2026 года.**
