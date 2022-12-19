import 'package:dairy/home_page.dart';
import 'package:dairy/list_page.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,

          automaticallyImplyLeading: true,
          title: const Text("Dairy Farm"),
          centerTitle: true,
          bottom: const TabBar(tabs: [Tab(text: "Home"), Tab(text: "List")]),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [HomeScreen(), DailyRecordList()],
        ),
      ),
    );
  }
}
