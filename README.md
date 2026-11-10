# Volga IT 2026 — шпаргалки Flutter / ОС Аврора

Материалы для подготовки к практическим заданиям. **Это не официальные задачи финала 2026.**

## ⭐ Главное: отчёты и CSV

- [Начни здесь — CSV и отчёты](!!!_НАЧНИ_ЗДЕСЬ_ОТЧЕТ_CSV.md)
- [Разбор задания «Сформировать отчёт»](REPORT_01_ГОТОВОЕ_РЕШЕНИЕ.md)
- [Готовый CSV-сервис на package:csv](report_example/lib/report_service.dart)
- [PDF-генерация с package:pdf](report_example/lib/pdf_report.dart)
- [Консольный запуск](report_example/bin/main.dart)
- [Тесты CSV](report_example/test/report_service_test.dart)
- [Образец report.csv](report_example/samples/report.csv) и [summary.csv](report_example/samples/summary.csv)
- [12 заданий на отчёты](practice/REPORT_TASKS.md)

### Проверка отчётов

```bash
cd report_example
dart pub get
dart run bin/main.dart
dart test
```

## Шпаргалки

- [Dart / Flutter: быстрые команды](docs/00-quick-reference.md)
- [Flutter UI — самый простой CRUD-экран](docs/01-FLUTTER-BASICS.md)
- [CSV через пакет csv](docs/01-csv.md)
- [Особенности ОС Аврора](docs/02-AURORA.md)
- [url_launcher](docs/02-url-launcher.md)
- [CRUD и аналитика](docs/04-crud-analytics.md)
- [20 тренировочных задач](practice/20-scenarios.md)
- [Чек-лист сдачи](checklists/SUBMISSION.md)

### Важно

Данные примеры требуют проверки на конкретной версии Aurora SDK и устройстве. Чистые расчёты и CSV на Dart проще переносить, чем платформенные функции файлов, камеры и GPS. PDF для русского текста требует TTF с кириллицей.

Часть материалов перенесена в репозиторий и адаптирована для чтения онлайн; это **ещё не полная копия исходного ZIP из 55 файлов**.
