# url_launcher — открыть ссылку

## Добавить пакет
В `pubspec.yaml` укажите **версию, совместимую с вашей сборкой Авроры**:
```yaml
dependencies:
  url_launcher: any
```
`any` указан только как учебный пример; перед соревнованием зафиксируйте проверенную версию.

## Самый короткий код
```dart
import 'package:url_launcher/url_launcher.dart';

Future<void> openWebsite(String url) async {
  final uri = Uri.parse(url);
  final ok = await launchUrl(uri);
  if (!ok) throw Exception('Не удалось открыть ссылку');
}
```

```dart
await openWebsite('https://example.com');
```

## Телефон и почта
```dart
await launchUrl(Uri(scheme: 'tel', path: '+79990000000'));
await launchUrl(Uri(scheme: 'mailto', path: 'test@example.com'));
```

## Файл
Открытие `file://` зависит от платформенной реализации, доступности файла и зарегистрированного обработчика. **Не считай поддержку локальных файлов гарантированной на Авроре**. Проверь на реальном устройстве.

## Если не работает
- URI должен быть корректным.
- Проверь наличие платформенного плагина Авроры и его версию.
- Обрабатывай `false` и исключения через `try/catch`.
- Не добавляй обязательное открытие ссылки в `build()` — запускай по нажатию кнопки.
