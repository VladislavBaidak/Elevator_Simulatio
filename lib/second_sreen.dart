//second_sreen.dart
import 'package:flutter/material.dart';
import 'building.dart';
import 'buildingdetialscreen.dart';
import 'database_helper.dart';

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
    try {
      await BuildingDatabase.insertBuilding(name, floors);
      await _loadBuildings(); // Reload buildings after insertion
    } catch (e) {
      // Handle the exception, e.g., show an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Друга сторінка'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Додати будинок'),
                        content: Container(
                          width: 250.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: nameController,
                                decoration:
                                    InputDecoration(labelText: 'Ім\'я будинку'),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: floorsController,
                                decoration: InputDecoration(
                                    labelText: 'Кількість поверхів'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              String name = nameController.text;
                              int floors =
                                  int.tryParse(floorsController.text) ?? 0;

                              await _insertBuilding(name, floors);
                              await _loadBuildings();
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Скасувати'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Додати будинок'),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FloorScreen(building: buildings[index]),
                      ),
                    );
                  },
                  child: Text(buildings[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
