import 'package:flutter/material.dart';
import 'courses_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String firstName = '';
  String lastName = '';


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? HomeScreen(
              firstName: firstName,
              lastName: lastName,
              onNameChange: (String name) {
                setState(() {
                  firstName = name;
                });
              },
              onLastNameChange: (String surname) {
                setState(() {
                  lastName = surname;
                });
              },
            )
          : CoursesScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Color verde para la pestaña seleccionada
        unselectedItemColor: Colors.grey, // Color gris para las no seleccionadas
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Cursos',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final Function(String) onNameChange;
  final Function(String) onLastNameChange;

  HomeScreen({
    required this.firstName,
    required this.lastName,
    required this.onNameChange,
    required this.onLastNameChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCourseApp'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) {
                onNameChange(value);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Apellido'),
              onChanged: (value) {
                onLastNameChange(value);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Bienvenido $firstName $lastName a MyCourseApp!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursesScreen()),
                );
              },
              child: Text('Quiero ver los cursos'),
            ),
          ],
        ),
      ),
    );
  }
}
