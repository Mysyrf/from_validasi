import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _prodiController = TextEditingController();
  final _semesterController = TextEditingController();

  @override
  void dispose() {
    // Bersihkan controller saat widget dibuang
    _nimController.dispose();
    _namaController.dispose();
    _prodiController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('NIM: ${_nimController.text}');
      print('Nama: ${_namaController.text}');
      print('Prodi: ${_prodiController.text}');
      print('Semester: ${_semesterController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disubmit')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(hintText: 'NIM'),
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(hintText: 'Nama'),
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _prodiController,
                decoration: const InputDecoration(hintText: 'Program Studi'),
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? 'Program Studi wajib diisi' : null,
              ),
              TextFormField(
                controller: _semesterController,
                decoration: const InputDecoration(hintText: 'Semester'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Semester wajib diisi';
                  final num = int.tryParse(value);
                  if (num == null || num <= 0) return 'Semester tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
