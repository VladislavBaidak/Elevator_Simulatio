//buildingdetialscreen.dart

import 'package:flutter/material.dart';
import 'building.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FloorScreen extends StatefulWidget {
  final Building building;

  FloorScreen({required this.building});

  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  late List<int> floorStack;
  late int currentFloor;
  late int nextFloor;
  late int elevatorDirection;
  late Timer elevatorTimer;
  late FlutterLocalNotificationsPlugin notifications;

  @override
  void initState() {
    super.initState();
    floorStack = _generateRandomFloorStack();
    currentFloor = 1;
    nextFloor = floorStack.isNotEmpty ? floorStack.first : 1;
    elevatorDirection = 0; // 0 - стояти, 1 - рух вверх, -1 - рух вниз

    // Початок роботи ліфта
    startElevator();

    // Ініціалізація плагіну локальних сповіщень
    notifications = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    notifications.initialize(initializationSettings);
  }

  @override
  void dispose() {
    elevatorTimer.cancel();
    super.dispose();
  }

  void startElevator() {
    elevatorTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Виведення значень стека, поточного та наступного чисел кожну секунду
      print(
          "Stack: $floorStack, Current Floor: $currentFloor, Next Floor: $nextFloor");

      // Зміна напрямку руху ліфта
      if (currentFloor < nextFloor) {
        elevatorDirection = 1;
      } else if (currentFloor > nextFloor) {
        elevatorDirection = -1;
      } else {
        elevatorDirection = 0;
      }

      // Рух ліфта
      if (elevatorDirection != 0) {
        setState(() {
          currentFloor += elevatorDirection;
        });
      }

      // Перевірка, чи ліфт досяг наступного поверху
      if (currentFloor == nextFloor) {
        // Подсвічування поточного поверху жовтим
        setState(() {});

        // Пауза на 2 секунди перед наступним кроком
        Future.delayed(Duration(seconds: 2), () {
          // Подсвічування поточного поверху жовтим та перехід до наступного числа
          if (currentFloor == nextFloor) {
            nextFloor = floorStack.removeAt(0);
          }
          setState(() {});

          // Відправка фонового уведомлення
          sendNotification(currentFloor);
        });
      }

      // Перевірка закінчення роботи ліфта
      if (floorStack.isEmpty && currentFloor == nextFloor) {
        timer.cancel();
        // Ліфт завершив роботу, обнулення значень
        setState(() {
          floorStack = _generateRandomFloorStack();
          currentFloor = 1;
          nextFloor = floorStack.isNotEmpty ? floorStack.first : 1;
        });
        // Початок нового циклу роботи ліфта
        startElevator();
      }
    });
  }

  List<int> _generateRandomFloorStack() {
    Random random = Random();
    List<int> stack = List.generate(widget.building.floors,
        (index) => random.nextInt(widget.building.floors) + 1);
    return stack;
  }

  Future<void> sendNotification(int floor) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'floor_notification_channel',
      'Floor Notification Channel',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await notifications.show(
      0,
      'Ліфт на ${widget.building.name}',
      'Поточний поверх: $floor',
      platformChannelSpecifics,
      payload: 'floor_notification',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поверхи будівлі ${widget.building.name}'),
      ),
      body: ListView.builder(
        itemCount: widget.building.floors,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              // Обробка натискання на поверх
              // Тут ви можете додати код для виведення деталей про цей поверх або інші дії
            },
            style: ElevatedButton.styleFrom(
              primary: currentFloor == index + 1 && currentFloor != nextFloor
                  ? Colors.yellow
                  : (currentFloor == nextFloor && currentFloor == index + 1
                      ? Colors.green
                      : null),
            ),
            child: Text('Поверх ${index + 1}'),
          );
        },
      ),
    );
  }
}
