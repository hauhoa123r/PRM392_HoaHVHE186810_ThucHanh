// Lab 3 - Advanced Dart Practice Exercises
// Run in the VS Code terminal with:
// dart run lab3_advanced_dart.dart

import 'dart:async';
import 'dart:convert';

Future<void> main() async {
  print('===== EXERCISE 1: PRODUCT MODEL & REPOSITORY =====');
  await exercise1();

  print('\n===== EXERCISE 2: USER REPOSITORY WITH JSON =====');
  await exercise2();

  print('\n===== EXERCISE 3: ASYNC + MICROTASK DEBUGGING =====');
  await exercise3();

  print('\n===== EXERCISE 4: STREAM TRANSFORMATION =====');
  await exercise4();

  print('\n===== EXERCISE 5: FACTORY CONSTRUCTOR & CACHE =====');
  exercise5();
}

// Exercise 1: A data model representing one product.
class Product {
  const Product({required this.id, required this.name, required this.price});

  final int id;
  final String name;
  final double price;

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

// The repository returns existing products and broadcasts live additions.
class ProductRepository {
  final List<Product> _products = [
    const Product(id: 1, name: 'Keyboard', price: 25.0),
    const Product(id: 2, name: 'Mouse', price: 15.5),
  ];

  final StreamController<Product> _addedController =
      StreamController<Product>.broadcast();

  // Future simulates loading a product list from a database or an API.
  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<Product>.unmodifiable(_products);
  }

  // A broadcast Stream lets more than one listener receive live updates.
  Stream<Product> liveAdded() => _addedController.stream;

  void addProduct(Product product) {
    _products.add(product);
    _addedController.add(product);
  }

  Future<void> dispose() => _addedController.close();
}

Future<void> exercise1() async {
  final repository = ProductRepository();

  final products = await repository.getAll();
  print('Products loaded with Future:');
  for (final product in products) {
    print('  $product');
  }

  // Subscribe before adding so the event is received.
  final subscription = repository.liveAdded().listen((product) {
    print('Live product added: $product');
  });

  repository.addProduct(
    const Product(id: 3, name: 'Headphones', price: 45.0),
  );
  await Future.delayed(const Duration(milliseconds: 100));
  await subscription.cancel();
  await repository.dispose();
}

// Exercise 2: User converts a JSON map into a typed Dart object.
class User {
  const User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'] as String, email: json['email'] as String);
  }

  final String name;
  final String email;

  @override
  String toString() => 'User(name: $name, email: $email)';
}

class UserRepository {
  // This string represents JSON returned by an API endpoint.
  static const String _apiResponse = '''
    [
      {"name": "An", "email": "an@example.com"},
      {"name": "Binh", "email": "binh@example.com"}
    ]
  ''';

  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final List<dynamic> jsonList = jsonDecode(_apiResponse) as List<dynamic>;
    return jsonList
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

Future<void> exercise2() async {
  final users = await UserRepository().fetchUsers();
  print('Users parsed from JSON:');
  for (final user in users) {
    print('  $user');
  }
}

Future<void> exercise3() async {
  print('1. Synchronous: start');

  // Microtasks run after synchronous code but before the event queue.
  scheduleMicrotask(() => print('3. Microtask callback'));

  // Future(() {}) adds its callback to the event queue.
  Future<void>(() => print('4. Event queue callback'));

  print('2. Synchronous: end');

  // Give both queues a chance to finish before the next exercise starts.
  await Future.delayed(const Duration(milliseconds: 50));
  print('Explanation: the microtask queue has priority over the event queue.');
}

Future<void> exercise4() async {
  // map squares each number; where keeps only even squared results.
  final Stream<int> evenSquares = Stream<int>.fromIterable([1, 2, 3, 4, 5])
      .map((number) => number * number)
      .where((square) => square.isEven);

  print('Even squares from 1 to 5:');
  await for (final square in evenSquares) {
    print('  $square');
  }
}

// Exercise 5: The private constructor prevents direct external construction.
class Settings {
  Settings._internal();

  static final Settings _instance = Settings._internal();

  // The factory always returns the cached singleton object.
  factory Settings() => _instance;

  String theme = 'Light';
}

void exercise5() {
  final firstSettings = Settings();
  final secondSettings = Settings();
  secondSettings.theme = 'Dark';

  print('First instance theme: ${firstSettings.theme}');
  print('Second instance theme: ${secondSettings.theme}');
  print('identical(firstSettings, secondSettings): '
      '${identical(firstSettings, secondSettings)}');
}
