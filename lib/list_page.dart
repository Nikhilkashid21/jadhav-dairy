import 'package:dairy/add_dairyproduct.dart';
import 'package:dairy/data_helper.dart';
import 'package:dairy/db_manager.dart';
import 'package:flutter/material.dart';

class DailyRecordList extends StatefulWidget {
  const DailyRecordList({super.key});

  @override
  State<DailyRecordList> createState() => _DailyRecordListState();
}

class _DailyRecordListState extends State<DailyRecordList> {
  final DbDairyProductManager dbManager =
      DbDairyProductManager(); ////instance of Database

  int? updateIndex;
  ////Display Inserting Record
  List<DairyHelper>? dairyproductlist;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: dbManager.getProductList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dairyproductlist = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      dairyproductlist == null ? 0 : dairyproductlist!.length,
                  itemBuilder: (BuildContext context, int index) {
                    DairyHelper st = dairyproductlist![index];

                    return Card(
                      // color: Colors.green,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date: ${st.date}"),
                                Text("Baffalo Milk: ${st.baffaloMilk}"),
                                Text("Cow Milk: ${st.cowMilk}"),
                                Text("Paneer: ${st.paneer}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DairyProduct(
                                        item: st,
                                      )));

                              //   _nameController.text = st.name;
                              //   _courseController.text = st.course;
                              //   _priceController.text = st.price.toString();
                              //     _feesController.text = st.fees.toString();
                              // student = st;

                              updateIndex = index;
                            },
                          ),
                          IconButton(
                            // onPressed: () {
                            // dbManager.deleteProduct(st.id);
                            // print("Delete Item");

                            // setState(() {
                            //   dairyproductlist!.removeAt(index);
                            // });
                            // },
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      content: const Text(
                                          "Are you sure you want to delete ?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            dbManager.deleteProduct(st.id);
                                            print("Delete Item");

                                            setState(() {
                                              dairyproductlist!.removeAt(index);
                                            });
                                            Navigator.pop(context);
                                          },
                                          color: Colors.green,
                                          child: const Text('Yes',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white)),
                                        )
                                      ],
                                    );
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
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const DailyRecord()));

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DairyProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
