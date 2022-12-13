class Student {
  int? id;
  String name;
  String course;
  int price;
  double fees;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.price,
    required this.fees,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'course': course,
      'price': price,
      'fees': fees,
    };
  }
}
