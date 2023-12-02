//home_screen.dart
import 'package:flutter/material.dart';
import "second_sreen.dart";

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Мій тестовий проєкт'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 20.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Text(
                    'Тестовий проєкт',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/front.png', // Змініть шлях та ім'я файлу на свої
                width: 150.0,
                height: 150.0,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
                child: Text('Натисни мене'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
