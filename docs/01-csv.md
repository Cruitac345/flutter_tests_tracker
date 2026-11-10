# CSV: экспорт и импорт через пакет csv

Рабочий полноценный пример — [report_service.dart](../report_example/lib/report_service.dart).

```yaml
dependencies:
  csv: ^8.0.0
```

## Экспорт (csv 8.x)
```dart
import 'package:csv/csv.dart';

final rows = [
  ['Категория', 'Сумма'],
  ['Еда', '120.50'],
  ['Такси', '300.00'],
];

final text = Csv(fieldDelimiter: ';').encode(rows);
```

## Импорт
```dart
final rows = Csv(fieldDelimiter: ';').decode(text);
for (final row in rows.skip(1)) {
  print(row);
}
```

## Экспорт на диск
```dart
import 'dart:convert';
import 'dart:io';

await File('/доступный/каталог/report.csv').writeAsBytes([
  0xEF, 0xBB, 0xBF, ...utf8.encode(text),
]);
```
На Авроре выбери разрешённый каталог приложения, а не произвольный путь.

## Три частые ошибки
1. CSV нельзя корректно читать через `split(',')`.
2. Перед экспортом сначала фильтруй данные и считай итоги.
3. Строка «ИТОГО» при импорте должна пропускаться.
