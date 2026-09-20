// Lab 2 - Dart Essentials Practice Lab
// Run in the VS Code terminal with:
// dart run lab2_dart_essentials.dart

Future<void> main() async {
  print('===== EXERCISE 1: BASIC SYNTAX & DATA TYPES =====');
  exercise1();

  print('\n===== EXERCISE 2: COLLECTIONS & OPERATORS =====');
  exercise2();

  print('\n===== EXERCISE 3: CONTROL FLOW & FUNCTIONS =====');
  exercise3();

  print('\n===== EXERCISE 4: INTRO TO OOP =====');
  exercise4();

  print('\n===== EXERCISE 5: ASYNC, NULL SAFETY & STREAMS =====');
  await exercise5();
}

// Exercise 1: Variables use Dart's core data types and string interpolation.
void exercise1() {
  int age = 20;
  double gpa = 3.75;
  String name = 'Nguyen Van An';
  bool isStudent = true;

  print('Name: $name');
  print('Age: $age');
  print('GPA: $gpa');
  print('Is student: $isStudent');
  print('Next year, $name will be ${age + 1} years old.');
}

// Exercise 2: List keeps order, Set keeps unique items, and Map stores pairs.
void exercise2() {
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(20);
  print('List after add/remove: $numbers');
  print('First item by index: ${numbers[0]}');

  int total = numbers[0] + numbers[1];
  int difference = numbers[2] - numbers[0];
  bool isEqual = numbers[0] == 10;
  bool isValid = total > 30 && isEqual;
  String result = isValid ? 'Valid result' : 'Invalid result';
  print('Total (+): $total, difference (-): $difference');
  print('Equal (==): $isEqual, AND (&&): $isValid, ternary: $result');

  Set<int> uniqueNumbers = {1, 2, 2, 3};
  uniqueNumbers.add(4);
  uniqueNumbers.remove(1);
  print('Set with unique values: $uniqueNumbers');

  Map<String, dynamic> student = {'name': 'An', 'score': 90};
  student['class'] = 'PRM392';
  print('Map: $student');
  print("Student's score from map: ${student['score']}");
}

// Exercise 3: Conditions, switch, loops, and two kinds of functions.
void exercise3() {
  int score = 85;
  if (score >= 50) {
    print('Score $score: Pass');
  } else {
    print('Score $score: Fail');
  }

  String day = 'Monday';
  switch (day) {
    case 'Monday':
      print('$day: Start of the school week');
      break;
    case 'Saturday':
    case 'Sunday':
      print('$day: Weekend');
      break;
    default:
      print('$day: A normal weekday');
  }

  List<String> subjects = ['Dart', 'Flutter', 'Mobile Development'];
  print('for loop:');
  for (int index = 0; index < subjects.length; index++) {
    print('  ${index + 1}. ${subjects[index]}');
  }

  print('for-in loop:');
  for (final subject in subjects) {
    print('  $subject');
  }

  print('forEach loop:');
  subjects.forEach((subject) => print('  $subject'));

  print('Normal function result: ${multiply(4, 5)}');
  print('Arrow function result: ${square(6)}');
}

// A normal function uses a block body and an explicit return statement.
int multiply(int firstNumber, int secondNumber) {
  return firstNumber * secondNumber;
}

// An arrow function is suitable for a single expression.
int square(int number) => number * number;

// Exercise 4: Car is a parent class with a default and a named constructor.
class Car {
  Car(this.brand);

  Car.electric(this.brand);

  final String brand;

  void describe() {
    print('$brand is a gasoline car.');
  }
}

// ElectricCar inherits Car and replaces its describe method.
class ElectricCar extends Car {
  ElectricCar(String brand, this.batteryPercentage) : super.electric(brand);

  final int batteryPercentage;

  @override
  void describe() {
    print('$brand is an electric car with $batteryPercentage% battery.');
  }
}

void exercise4() {
  Car car = Car('Toyota');
  Car namedConstructorCar = Car.electric('Tesla');
  ElectricCar electricCar = ElectricCar('VinFast', 85);

  car.describe();
  namedConstructorCar.describe();
  electricCar.describe();
}

// Exercise 5: Future simulates a loading task, then a Stream emits integers.
Future<void> exercise5() async {
  print('Loading profile...');
  String profile = await loadProfile();
  print(profile);

  // ? makes a variable nullable; ?. avoids calling a method on null.
  String? nickname;
  print('Nickname: ${nickname?.toUpperCase() ?? 'Not provided'}');

  // ?? supplies a default value when the value on its left is null.
  String? city;
  print('City: ${city ?? 'Ho Chi Minh City'}');

  // ! tells Dart this value is definitely non-null at this point.
  String? confirmedName = 'An';
  print('Confirmed name: ${confirmedName!}');

  print('Stream values:');
  await for (final value in numberStream()) {
    print('  Received: $value');
  }
}

// Future.delayed simulates an asynchronous task such as a network request.
Future<String> loadProfile() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Profile loaded successfully.';
}

// A Stream sends several values over time.
Stream<int> numberStream() async* {
  for (int value = 1; value <= 3; value++) {
    await Future.delayed(const Duration(milliseconds: 300));
    yield value;
  }
}
