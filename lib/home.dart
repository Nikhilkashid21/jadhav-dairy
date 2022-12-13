import 'package:dairy/db_manager.dart';
import 'package:dairy/data_helper.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final DbStudentManager dbManager =
      new DbStudentManager(); ////instance of Database

  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _priceController = TextEditingController();
  final _feesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Student? student;
  int? updateIndex;

  ////Display Inserting Record
  List<Student>? studentlist;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: true,
          title: const Text("SQFlite Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required Name";
                            } else {
                              return null;
                            }
                            // value!.isNotEmpty ? null : 'Name should be empty';
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Caurse",
                          ),
                          controller: _courseController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required course Name";
                            } else {
                              return null;
                            }

                            // value!.isNotEmpty ? null : 'Caurse should be empty';
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Price",
                          ),
                          controller: _priceController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required price";
                            } else {
                              return null;
                            }

                            // value!.isNotEmpty ? null : 'Caurse should be empty';
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Fees",
                          ),
                          controller: _feesController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Required fees";
                            } else {
                              return null;
                            }
                            // value!.isNotEmpty ? null : 'Caurse should be empty';
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            _submitStudent(context);
                          },
                          color: Colors.green,
                          child: Container(
                            width: width * 0.9,
                            child: const Center(
                              child: Text('Submit',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                          future: dbManager.getStudentList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              studentlist = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: studentlist == null
                                      ? 0
                                      : studentlist!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Student st = studentlist![index];

                                    return Card(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width * 0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Student Name: ${st.name}"),
                                                Text(
                                                    "Course Name: ${st.course}"),
                                                Text("Price: ${st.price}"),
                                                Text("Fees: ${st.fees}"),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _nameController.text = st.name;
                                              _courseController.text =
                                                  st.course;
                                              _priceController.text =
                                                  st.price.toString();
                                              _feesController.text =
                                                  st.fees.toString();
                                              student = st;

                                              updateIndex = index;
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              dbManager.deleteStudent(st.id);
                                              print("Delete Item");

                                              setState(() {
                                                studentlist!.removeAt(index);
                                              });
                                            },
                                            icon: Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                            return new CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  void _submitStudent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (student == null) {
        // ignore: unnecessary_new
        Student st = new Student(
            name: _nameController.text,
            course: _courseController.text,
            price: int.parse(_priceController.text),
            fees: double.parse(_feesController.text));
        dbManager.insertStudent(st).then((id) => {
              _nameController.clear(),
              _courseController.clear(),
              _priceController.clear(),
              _feesController.clear(),
              print("added student in db $id")
            });
      } else {
        student!.name = _nameController.text;
        student!.course = _courseController.text;
        student!.price = int.parse(_priceController.text);
        student!.fees = double.parse(_feesController.text);

        dbManager.updateStudent(student!).then((id) => {
              setState(() {
                studentlist![updateIndex!].name = _nameController.text;
                studentlist![updateIndex!].course = _courseController.text;
                studentlist![updateIndex!].price =
                    int.parse(_priceController.text);
                studentlist![updateIndex!].fees =
                    double.parse(_feesController.text);
              }),
              _nameController.clear(),
              _courseController.clear(),
              _priceController.clear(),
              _feesController.clear(),
              student = null,
            });
      }
    }
  }
}
