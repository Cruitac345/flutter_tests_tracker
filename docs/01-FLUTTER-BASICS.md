# Минимальный Flutter UI для олимпиады

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  final items = <String>[];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Задачи')),
    body: Column(children: [
      TextField(controller: controller),
      ElevatedButton(
        onPressed: () {
          if (controller.text.trim().isEmpty) return;
          setState(() => items.add(controller.text.trim()));
          controller.clear();
        },
        child: const Text('Добавить'),
      ),
      Expanded(child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => items.removeAt(i)),
          ),
        ),
      )),
    ]),
  );
}
```

Это пример интерфейса без хранения: после перезапуска данные пропадут. Для постоянного хранения добавь SQLite или другую совместимую базу.
