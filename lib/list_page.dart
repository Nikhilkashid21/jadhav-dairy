import 'package:dairy/add_daily_record.dart';
import 'package:dairy/data_helper.dart';
import 'package:dairy/db_manager.dart';
import 'package:flutter/material.dart';

class DailyRecordList extends StatefulWidget {
  const DailyRecordList({super.key});

  @override
  State<DailyRecordList> createState() => _DailyRecordListState();
}

class _DailyRecordListState extends State<DailyRecordList> {
  final DbStudentManager dbManager =
      DbStudentManager(); ////instance of Database

  final _formKey = GlobalKey<FormState>();
  Student? student;
  int? updateIndex;
  ////Display Inserting Record
  List<Student>? studentlist;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: dbManager.getStudentList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              studentlist = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: studentlist == null ? 0 : studentlist!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Student st = studentlist![index];

                    return Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Student Name: ${st.name}"),
                                Text("Course Name: ${st.course}"),
                                Text("Price: ${st.price}"),
                                Text("Fees: ${st.fees}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              // _nameController.text = st.name;
                              // _courseController.text =
                              //     st.course;
                              // _priceController.text =
                              //     st.price.toString();
                              // _feesController.text =
                              //     st.fees.toString();
                              // student = st;

                              // updateIndex = index;
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              dbManager.deleteStudent(st.id);
                              print("Delete Item");

                              setState(() {
                                studentlist!.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    );
                  });
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DailyRecord()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
