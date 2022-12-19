import 'package:dairy/data_helper.dart';
import 'package:dairy/db_manager.dart';
import 'package:flutter/material.dart';

class DairyProduct extends StatefulWidget {
  final DairyHelper? item;
  const DairyProduct({super.key, this.item});

  @override
  State<DairyProduct> createState() => _DairyProductState();
}

class _DairyProductState extends State<DairyProduct> {
  final DbDairyProductManager dbManager =
      DbDairyProductManager(); ////instance of Database

  final _formKey = GlobalKey<FormState>();
  DairyHelper? dairyHelper;
  int? updateIndex;

  ////Display Inserting Record
  List<DairyHelper>? dairyProductList;

  TextEditingController dateController = TextEditingController();
  TextEditingController buffaloMilkController = TextEditingController();
  TextEditingController cowMilkController = TextEditingController();
  TextEditingController dahiController = TextEditingController();
  TextEditingController lassiController = TextEditingController();
  TextEditingController butterMilkController = TextEditingController();
  TextEditingController chahaController = TextEditingController();
  TextEditingController paneerController = TextEditingController();
  TextEditingController greenpieceController = TextEditingController();
  TextEditingController khavaController = TextEditingController();
  TextEditingController basundiController = TextEditingController();

  DateTime currentDate = DateTime.now();

  Future<void> selectDate(BuildContext context, pickerDate) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        currentDate = pickedDate;
        pickerDate(Localizations.of<MaterialLocalizations>(
                context, MaterialLocalizations)
            ?.formatCompactDate(currentDate));
      });
    }

    debugPrint("Date:-$currentDate");
  }

  @override
  void initState() {
    if (widget.item != null) {
      dateController.text = widget.item!.date;
      buffaloMilkController.text = widget.item!.baffaloMilk.toString();
      cowMilkController.text = widget.item!.cowMilk.toString();
      dahiController.text = widget.item!.dhahi.toString();
      lassiController.text = widget.item!.lassi.toString();
      butterMilkController.text = widget.item!.butterMilk.toString();
      chahaController.text = widget.item!.chahaPowder.toString();
      paneerController.text = widget.item!.paneer.toString();
      greenpieceController.text = widget.item!.greenpiece.toString();
      khavaController.text = widget.item!.khava.toString();
      basundiController.text = widget.item!.basundi.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: const Text("Daily Record"),
        centerTitle: true,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextFormField(
                          controller: dateController,
                          onTap: () {
                            selectDate(context, (pickerDate) {
                              dateController.text = pickerDate;
                            });
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            fillColor: Colors.grey,
                            labelText: 'Date',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: buffaloMilkController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "*Required Buffalo Milk";
                                } else {
                                  return null;
                                }
                                // value!.isNotEmpty ? null : 'Name should be empty';
                              },
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Buffalo Milk",
                                labelText: 'Buffalo Milk',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: cowMilkController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Cow Milk",
                                labelText: 'Cow Milk',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: dahiController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Dhahi",
                                labelText: 'Dhahi',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: lassiController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Lassi",
                                labelText: 'Lassi',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: butterMilkController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Butter Milk",
                                labelText: 'Butter Milk',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: chahaController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Chaha Powder",
                                labelText: 'Chaha Powder',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: paneerController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Paneer",
                                labelText: 'Paneer',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: greenpieceController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Green piece",
                                labelText: 'Green Piece',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: basundiController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Basundi",
                                labelText: 'Basundi',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: khavaController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.lightGreen, width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                fillColor: Colors.grey,
                                hintText: "Khava",
                                labelText: 'Khava',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          _submitStudent(context);
                          Navigator.pop(context);
                        },

                        // minWidth: 100.0,
                        height: 45,
                        // color: Colors.grey[100],
                        color: Colors.blue,
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
                        height: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _submitStudent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (dairyHelper == null) {
        // ignore: unnecessary_new
        DairyHelper st = new DairyHelper(
            date: dateController.text,
            baffaloMilk: double.parse(buffaloMilkController.text),
            cowMilk: double.parse(cowMilkController.text),
            dhahi: double.parse(dahiController.text),
            lassi: double.parse(lassiController.text),
            butterMilk: double.parse(butterMilkController.text),
            chahaPowder: double.parse(chahaController.text),
            paneer: double.parse(paneerController.text),
            greenpiece: double.parse(greenpieceController.text),
            basundi: double.parse(basundiController.text),
            khava: double.parse(khavaController.text));

        dbManager.insertProduct(st).then((id) => {
              dateController.clear(),
              buffaloMilkController.clear(),
              cowMilkController.clear(),
              dahiController.clear(),
              lassiController.clear(),
              butterMilkController.clear(),
              chahaController.clear(),
              greenpieceController.clear(),
              paneerController.clear(),
              basundiController.clear(),
              khavaController.clear(),
              print("added student in db $id")
            });
      } else {
        dairyHelper!.date = dateController.text;
        dairyHelper!.baffaloMilk = double.parse(buffaloMilkController.text);
        dairyHelper!.cowMilk = double.parse(cowMilkController.text);

        dairyHelper!.dhahi = double.parse(dahiController.text);
        dairyHelper!.lassi = double.parse(lassiController.text);
        dairyHelper!.butterMilk = double.parse(butterMilkController.text);
        dairyHelper!.chahaPowder = double.parse(chahaController.text);
        dairyHelper!.paneer = double.parse(paneerController.text);
        dairyHelper!.greenpiece = double.parse(greenpieceController.text);
        dairyHelper!.basundi = double.parse(basundiController.text);
        dairyHelper!.khava = double.parse(khavaController.text);

        dbManager.updateProduct(dairyHelper!).then((id) => {
              setState(() {
                dairyProductList![updateIndex!].date = dateController.text;
                dairyProductList![updateIndex!].baffaloMilk =
                    double.parse(buffaloMilkController.text);
                dairyProductList![updateIndex!].cowMilk =
                    double.parse(cowMilkController.text);
                dairyProductList![updateIndex!].dhahi =
                    double.parse(dahiController.text);
                dairyProductList![updateIndex!].lassi =
                    double.parse(lassiController.text);
                dairyProductList![updateIndex!].butterMilk =
                    double.parse(butterMilkController.text);
                dairyProductList![updateIndex!].chahaPowder =
                    double.parse(chahaController.text);
                dairyProductList![updateIndex!].paneer =
                    double.parse(paneerController.text);
                dairyProductList![updateIndex!].greenpiece =
                    double.parse(greenpieceController.text);
                dairyProductList![updateIndex!].basundi =
                    double.parse(basundiController.text);
                dairyProductList![updateIndex!].khava =
                    double.parse(khavaController.text);
              }),
              dateController.clear(),
              buffaloMilkController.clear(),
              cowMilkController.clear(),
              dahiController.clear(),
              lassiController.clear,
              butterMilkController.clear(),
              chahaController.clear(),
              greenpieceController.clear(),
              paneerController.clear(),
              basundiController.clear(),
              khavaController.clear(),
              dairyHelper = null,
            });
      }
    }
  }
}
