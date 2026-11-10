# Готовый пример: отчёт CSV + PDF

- [lib/report_service.dart](lib/report_service.dart) — вычисления, экспорт/импорт через `package:csv`
- [bin/main.dart](bin/main.dart) — создание файлов `output/report.csv` и `output/summary.csv`
- [lib/pdf_report.dart](lib/pdf_report.dart) — создание PDF по переданным байтам TTF-шрифта
- [test/report_service_test.dart](test/report_service_test.dart) — тесты
- [Практика](../practice/REPORT_TASKS.md)

```bash
dart pub get
dart run bin/main.dart
dart test
```

Пример `main.dart` не создаёт PDF: для кириллицы передайте совместимый TTF-шрифт. UI-пример для Flutter также требует интеграции с вашим приложением.
