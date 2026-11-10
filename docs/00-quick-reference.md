# Шпаргалка Flutter / Dart / Аврора

## Список и фильтр
```dart
final filtered = expenses.where((e) => e.amountKopecks > 100000).toList();
final sum = expenses.fold<int>(0, (s, e) => s + e.amountKopecks);
```

## Обновление экрана
```dart
setState(() {
  items.add('Новая запись');
});
```

## Навигация
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailsPage()));
Navigator.pop(context);
```

## Диалог даты
```dart
final date = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2100),
);
```

## Проверить ошибки и зависимости
```bash
flutter-aurora doctor
flutter-aurora pub get
flutter-aurora analyze
```
Команды зависят от вашей установленной версии Flutter для Авроры.

## Чек-лист финала
- Приложение компилируется на целевом SDK.
- Старые функции не сломаны.
- Ошибки и пустые данные обработаны.
- Есть коммит в отдельной ветке и понятное описание изменений.
