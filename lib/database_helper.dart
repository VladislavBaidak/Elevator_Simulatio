//database_helper.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'building.dart';

class BuildingDatabase {
  static Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'buildings.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE buildings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, floors INTEGER)',
        );
      },
    );

    return database;
  }

  static Future<void> insertBuilding(String name, int floors) async {
    if (name.isNotEmpty && floors > 3) {
      Database database = await initializeDatabase();

      await database.insert(
        'buildings',
        {'name': name, 'floors': floors},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception(
          "Invalid input data: Name should not be empty, and floors should be more than 3.");
    }
  }

  static Future<List<Building>> loadBuildings() async {
    Database database = await initializeDatabase();
    List<Map<String, dynamic>> buildingMaps = await database.query('buildings');

    return buildingMaps.map((map) {
      return Building(
        id: map['id'],
        name: map['name'],
        floors: map['floors'],
      );
    }).toList();
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late List<Building> buildings;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController floorsController = TextEditingController();
  Building? selectedBuilding;

  @override
  void initState() {
    super.initState();
    buildings = [];
    _loadBuildings();
  }

  Future<void> _loadBuildings() async {
    List<Building> loadedBuildings = await BuildingDatabase.loadBuildings();

    setState(() {
      buildings = loadedBuildings;
    });
  }

  Future<void> _insertBuilding(String name, int floors) async {
    await BuildingDatabase.insertBuilding(name, floors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //... rest of the code remains the same
        );
  }
}
