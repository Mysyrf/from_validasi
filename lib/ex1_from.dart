import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Form Mahasiswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(backgroundColor: Colors.blue, title: Text(widget.title)),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'NIM'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nama'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Program Studi'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Semester'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar tombol
                  foregroundColor: Colors.white, // Warna teks
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: const Text('Submit'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Aksi ketika form valid
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
