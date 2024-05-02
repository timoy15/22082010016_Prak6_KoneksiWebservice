import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Universities in Indonesia'),
        ),
        body: UniversityList(),
      ),
    );
  }
}

class UniversityList extends StatefulWidget {
  @override
  _UniversityListState createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  List<dynamic> universities = [];

  Future<void> fetchUniversities() async {
    final response = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=Indonesia'));

    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: universities.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Memberikan jarak 8.0 pada bagian atas dan bawah
          child: ListTile(
            title: Text(universities[index]['name']),
            subtitle: Text(universities[index]['web_pages'][0]),
          ),
        );
      },
    );
  }
}
