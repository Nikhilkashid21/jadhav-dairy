import 'dart:async';
import 'package:dairy/data_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class DbStudentManager {
  Database? _database;

  Future<void> openDB() async {
    if (_database != null) {
      return;
    } else {
      try {
        _database = await openDatabase(
            p.join(await getDatabasesPath(), "student.db"),
            version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , course TEXT, price INTEGER , fees REAL )");
        });
      } catch (e) {
        // ignore: prefer_interpolation_to_compose_strings
        debugPrint("Exception:-" + e.toString());
      }
    }
  }

  Future<int> insertStudent(Student student) async {
    await openDB();
    return await _database!.insert('student', student.toMap());
  }

  Future<List<Student>> getStudentList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database!.query('student');

    return List.generate(maps.length, (index) {
      return Student(
        id: maps[index]['id'],
        name: maps[index]['name'],
        course: maps[index]['course'],
        price: maps[index]['price'],
        fees: maps[index]['fees'],
      );
    });
  }

  Future<int> updateStudent(Student student) async {
    await openDB();

    return await _database!.update('student', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  Future<void> deleteStudent(int? id) async {
    await openDB();
    await _database!.delete('student', where: 'id = ?', whereArgs: [id]);

    // return await _database!.delete('student', where:  'id = ?',whereArgs: [student.id]);
  }
}
