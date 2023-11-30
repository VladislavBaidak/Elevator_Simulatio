//building.dart
class Building {
  int id;
  String name;
  int floors;

  Building({required this.id, required this.name, required this.floors});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'floors': floors,
    };
  }
}
