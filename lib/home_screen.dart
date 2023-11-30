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
                top: 20.0, // Відстань від верхнього краю зображення
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Text(
                    'Тестовий проєкт',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),

              SizedBox(height: 20), // Прогортка між текстом і картинкою
              // Картинка
              Image.network(
                'https://w7.pngwing.com/pngs/438/187/png-transparent-board-game-graphic-design-miniature-wargaming-design-game-text-logo-thumbnail.png',
                width: 150.0, // Задайте ширину картинки за потребою
                height: 150.0, // Задайте висоту картинки за потребою
                // Можете також використовувати AssetImage для локальних ресурсів:
                // AssetImage('assets/your_image.png'),
              ),

              // Текст

              SizedBox(height: 20), // Прогортка між текстом і кнопкою

              // Кнопка
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
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