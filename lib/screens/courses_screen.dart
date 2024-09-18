import 'package:flutter/material.dart';
import '../widgets/course_card.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final List<Map<String, String>> courses = [
    {
      "title": "Adobe Photoshop",
      "description": "Edición de fotografía.",
      "image": "https://miro.medium.com/v2/resize:fit:995/0*vhX9RKAEbzH85rzu.png",
      "content": "Este curso incluye técnicas avanzadas de edición, capas, máscaras y filtros en Photoshop."
    },
    {
      "title": "Adobe Premiere Pro",
      "description": "Edición de video profesional.",
      "image": "https://blog.frame.io/wp-content/uploads/2023/02/insider-tips-premiere-pro.jpg",
      "content": "Aprenderás edición multicámara, efectos, y colorización avanzada con Premiere Pro."
    },
    {
      "title": "Adobe After Effects",
      "description": "Efectos visuales.",
      "image": "https://www.e-spincorp.com/wp-content/uploads/2020/04/Adobe-After-Effects-1.jpg",
      "content": "Crea efectos visuales, animaciones y gráficos en movimiento con After Effects."
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCourses = courses
        .where((course) =>
            course['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar curso',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetail(
                          title: filteredCourses[index]['title']!,
                          description: filteredCourses[index]['description']!,
                          imageUrl: filteredCourses[index]['image']!,
                          content: filteredCourses[index]['content']!,
                        ),
                      ),
                    );
                  },
                  child: CourseCard(
                    title: filteredCourses[index]['title']!,
                    description: filteredCourses[index]['description']!,
                    imageUrl: filteredCourses[index]['image']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String content;

  CourseDetail({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              "Contenido del Curso:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(content),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Mostrar el mensaje de confirmación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Felicidades'),
                        content: Text('Curso comprado exitosamente'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el diálogo
                              Navigator.of(context).pop(); // Vuelve a la pantalla anterior
                              Navigator.of(context).pop(); // Vuelve al inicio
                            },
                            child: Text('Volver al inicio'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Comprar Curso'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
