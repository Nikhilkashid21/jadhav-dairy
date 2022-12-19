// ignore_for_file: public_member_api_docs, sort_constructors_first
class DairyHelper {
  int? id;
  String date;
  double baffaloMilk;
  double cowMilk;
  double dhahi;
  double lassi;
  double butterMilk;
  double chahaPowder;
  double paneer;
  double greenpiece;
  double basundi;
  double khava;

  DairyHelper({
    this.id,
    required this.date,
    required this.baffaloMilk,
    required this.cowMilk,
    required this.dhahi,
    required this.lassi,
    required this.butterMilk,
    required this.chahaPowder,
    required this.paneer,
    required this.greenpiece,
    required this.basundi,
    required this.khava,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'baffaloMilk': baffaloMilk,
      'cowMilk': cowMilk,
      'dhahi': dhahi,
      'lassi': lassi,
      'butterMilk': butterMilk,
      'chahaPowder': chahaPowder,
      'paneer': paneer,
      'basundi': basundi,
      'greenpiece': greenpiece,
      'khava': khava,
    };
  }
}





















// class Student {
//   int? id;
//   String name;
//   String course;
//   int price;
//   double fees;

//   Student({
//     this.id,
//     required this.name,
//     required this.course,
//     required this.price,
//     required this.fees,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'course': course,
//       'price': price,
//       'fees': fees,
//     };
//   }
// }

