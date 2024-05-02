import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung IPK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TranskripMahasiswa(),
    );
  }
}

class TranskripMahasiswa extends StatefulWidget {
  @override
  _TranskripMahasiswaState createState() => _TranskripMahasiswaState();
}

class _TranskripMahasiswaState extends State<TranskripMahasiswa> {
  List<Map<String, dynamic>> transkrip = [
    {
      "kode": "MK001",
      "nama": "Matematika",
      "sks": 3,
      "nilai": "A",
    },
    {
      "kode": "MK002",
      "nama": "Fisika",
      "sks": 4,
      "nilai": "B+",
    },
    {
      "kode": "MK003",
      "nama": "Kimia",
      "sks": 3,
      "nilai": "A-",
    },
    {
      "kode": "MK004",
      "nama": "Bahasa Inggris",
      "sks": 2,
      "nilai": "B",
    },
  ];

  double hitungIPK() {
    double totalBobot = 0;
    int totalSKS = 0;

    for (var mataKuliah in transkrip) {
      int sks = mataKuliah['sks'];
      totalSKS += sks;

      String nilai = mataKuliah['nilai'];
      double bobot = 0;

      if (nilai == 'A') {
        bobot = 4.0;
      } else if (nilai == 'A-') {
        bobot = 3.7;
      } else if (nilai == 'B+') {
        bobot = 3.3;
      } else if (nilai == 'B') {
        bobot = 3.0;
      } else if (nilai == 'B-') {
        bobot = 2.7;
      } else if (nilai == 'C+') {
        bobot = 2.3;
      } else if (nilai == 'C') {
        bobot = 2.0;
      } else if (nilai == 'C-') {
        bobot = 1.7;
      } else if (nilai == 'D+') {
        bobot = 1.3;
      } else if (nilai == 'D') {
        bobot = 1.0;
      } else if (nilai == 'E') {
        bobot = 0;
      }

      totalBobot += bobot * sks;
    }

    double ipk = totalBobot / totalSKS;
    return ipk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transkrip Mahasiswa'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: transkrip.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(transkrip[index]['nama'])),
                      Text('SKS: ${transkrip[index]['sks']}'),
                      SizedBox(width: 10),
                      Text('Nilai: ${transkrip[index]['nilai']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Hitung IPK'),
              onPressed: () {
                double ipk = hitungIPK();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('IPK'),
                      content: Text('IPK Mahasiswa: $ipk'),
                      actions: [
                        TextButton(
                          child: Text('Tutup'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}