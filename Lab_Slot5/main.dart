class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void startEngine() {
    print('Khởi động phương tiện...');
  }
}

class Car extends Vehicle {
  bool isElectric;

  Car(String brand, int year, this.isElectric) : super(brand, year);

  Car.tesla(int year) : super('Tesla', year), isElectric = true;

  @override
  void startEngine() {
    if (isElectric) {
      print('$brand ($year): Khởi động êm ái bằng động cơ điện...');
    } else {
      print('$brand ($year): Brrr... Động cơ xăng đã khởi động!');
    }
  }
}

void main() {
  Car carNormal = Car('Toyota', 2022, false);
  carNormal.startEngine();

  Car carTesla = Car.tesla(2024);
  carTesla.startEngine();
}
