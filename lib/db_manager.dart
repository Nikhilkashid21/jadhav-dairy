import 'dart:async';
import 'package:dairy/data_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class DbDairyProductManager {
  Database? _database;

  Future<void> openDB() async {
    if (_database != null) {
      return;
    } else {
      try {
        _database = await openDatabase(
            p.join(await getDatabasesPath(), "dairyproduct.db"),
            version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE dairyproduct ( id INTEGER PRIMARY KEY AUTOINCREMENT, date  TEXT, baffaloMilk  REAL,  cowMilk  REAL, dhahi  REAL, lassi  REAL, butterMilk  REAL,  chahaPowder  REAL, paneer  REAL,  greenpiece  REAL, basundi  REAL,  khava  REAL )");
        });
      } catch (e) {
        // ignore: prefer_interpolation_to_compose_strings
        debugPrint("Exception:-" + e.toString());
      }
    }
  }

  Future<int> insertProduct(DairyHelper dairyHelper) async {
    await openDB();
    return await _database!.insert('dairyproduct', dairyHelper.toMap());
  }

  Future<List<DairyHelper>> getProductList() async {
    await openDB();
    final List<Map<String, dynamic>> maps =
        await _database!.query('dairyproduct');

    return List.generate(maps.length, (index) {
      return DairyHelper(
        id: maps[index]['id'],
        date: maps[index]['date'],
        baffaloMilk: maps[index]['baffaloMilk'],
        cowMilk: maps[index]['cowMilk'],
        dhahi: maps[index]['dhahi'],
        lassi: maps[index]['lassi'],
        butterMilk: maps[index]['butterMilk'],
        chahaPowder: maps[index]['chahaPowder'],
        paneer: maps[index]['paneer'],
        greenpiece: maps[index]['greenpiece'],
        basundi: maps[index]['basundi'],
        khava: maps[index]['khava'],
      );
    });
  }

  Future<int> updateProduct(DairyHelper dairyHelper) async {
    await openDB();

    return await _database!.update('dairyproduct', dairyHelper.toMap(),
        where: 'id = ?', whereArgs: [dairyHelper.id]);
  }

  Future<void> deleteProduct(int? id) async {
    await openDB();
    await _database!.delete('dairyproduct', where: 'id = ?', whereArgs: [id]);

  }
}
