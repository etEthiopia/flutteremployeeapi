class Employee {
  String name;
  int salary;
  int age;
  int id;
  String image;

  Employee({this.name, this.salary, this.age, this.id, this.image});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        name: json['employee_name'],
        id: json['id'],
        salary: json['employee_salary'],
        image: json['profile_image'],
        age: json['employee_age']);
  }

  @override
  String toString() =>
      'User { name: $name, id: $id, salary: $salary, age: $age, image: $image}';
}
