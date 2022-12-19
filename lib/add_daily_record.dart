// import 'package:dairy/data_helper.dart';
// import 'package:dairy/db_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class DailyRecord extends StatefulWidget {
//   const DailyRecord({super.key});

//   @override
//   State<DailyRecord> createState() => _DailyRecordState();
// }

// class _DailyRecordState extends State<DailyRecord> {
//   final DbStudentManager dbManager =
//       DbStudentManager(); ////instance of Database

//   final _nameController = TextEditingController();
//   final _courseController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _feesController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   Student? student;
//   int? updateIndex;

//   ////Display Inserting Record
//   List<Student>? studentlist;
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         automaticallyImplyLeading: true,
//         title: const Text("Daily Record"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Name",
//                         ),
//                         controller: _nameController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "*Required Name";
//                           } else {
//                             return null;
//                           }
//                           // value!.isNotEmpty ? null : 'Name should be empty';
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Caurse",
//                         ),
//                         controller: _courseController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "*Required course Name";
//                           } else {
//                             return null;
//                           }

//                           // value!.isNotEmpty ? null : 'Caurse should be empty';
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Price",
//                         ),
//                         controller: _priceController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "*Required price";
//                           } else {
//                             return null;
//                           }

//                           // value!.isNotEmpty ? null : 'Caurse should be empty';
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: "Fees",
//                         ),
//                         controller: _feesController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "*Required fees";
//                           } else {
//                             return null;
//                           }
//                           // value!.isNotEmpty ? null : 'Caurse should be empty';
//                         },
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           _submitStudent(context);
//                           Navigator.pop(context);
//                         },
//                         color: Colors.green,
//                         child: Container(
//                           width: width * 0.9,
//                           child: const Center(
//                             child: Text('Submit',
//                                 style: TextStyle(
//                                     fontSize: 16.0, color: Colors.white)),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitStudent(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       if (student == null) {
//         // ignore: unnecessary_new
//         Student st = new Student(
//             name: _nameController.text,
//             course: _courseController.text,
//             price: int.parse(_priceController.text),
//             fees: double.parse(_feesController.text));
//         dbManager.insertStudent(st).then((id) => {
//               _nameController.clear(),
//               _courseController.clear(),
//               _priceController.clear(),
//               _feesController.clear(),
//               print("added student in db $id")
//             });
//       } else {
//         student!.name = _nameController.text;
//         student!.course = _courseController.text;
//         student!.price = int.parse(_priceController.text);
//         student!.fees = double.parse(_feesController.text);

//         dbManager.updateStudent(student!).then((id) => {
//               setState(() {
//                 studentlist![updateIndex!].name = _nameController.text;
//                 studentlist![updateIndex!].course = _courseController.text;
//                 studentlist![updateIndex!].price =
//                     int.parse(_priceController.text);
//                 studentlist![updateIndex!].fees =
//                     double.parse(_feesController.text);
//               }),
//               _nameController.clear(),
//               _courseController.clear(),
//               _priceController.clear(),
//               _feesController.clear(),
//               student = null,
//             });
//       }
//     }
//   }
// }
