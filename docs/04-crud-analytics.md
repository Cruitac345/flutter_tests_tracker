# CRUD и аналитика — простая шпаргалка

CRUD = Create (добавить), Read (прочитать), Update (изменить), Delete (удалить).

```dart
final items = <String>[];
items.add('Расход');      // Create
print(items);             // Read
items[0] = 'Покупка';     // Update
items.removeAt(0);        // Delete
```

В Flutter после изменения обычного списка вызывай `setState`, чтобы экран перестроился.

## Сумма
```dart
final prices = [100, 250, 50];
final total = prices.fold<int>(0, (s, x) => s + x); // 400
```

## Фильтр
```dart
final big = prices.where((x) => x >= 100).toList();
```

## Группировка
```dart
final byCategory = <String, int>{};
for (final e in expenses) {
  byCategory.update(
    e.category,
    (old) => old + e.amountKopecks,
    ifAbsent: () => e.amountKopecks,
  );
}
```

Для БД CRUD выполняется асинхронно и требует обработки ошибок.
