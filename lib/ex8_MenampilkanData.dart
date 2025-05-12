import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Demo',
      home: const MyHomePage(title: 'Form Mahasiswa'),
      debugShowCheckedModeBanner: false,
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
  final prodiController = TextEditingController();
  final nimController = TextEditingController();
  final namaController = TextEditingController();
  final semesterController = TextEditingController();
  late FocusNode myFocusNode;

  void printValue() {
    print("Teks pada field program Studi: $prodiController");
  }

 void showData() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Nim : ${nimController.text}\n'
          'Nama : ${namaController.text}\n'
          'Prodi: ${prodiController.text}\n'
          'Semester: ${semesterController.text}',
        ),
      );
    },
  );
}

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    prodiController.addListener(printValue);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void validateInput() {
    FormState? form = formKey.currentState;

    const snackBar = SnackBar(content: Text('Semua data sudah tervalidasi'));

    if (form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
       showData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(backgroundColor: Colors.blue, title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nimController,
                decoration: const InputDecoration(
                  hintText: 'Nim',
                  labelText: 'Nim',
                  icon: Icon(Icons.person_pin),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nim tidak boleh kosong';
                  }
                  return null;
                },
                autofocus: true,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: myFocusNode,
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Alamat',
                  labelText: 'Alamat',
                  icon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: prodiController,
                decoration: const InputDecoration(
                  hintText: 'Program Studi',
                  labelText: 'Program Studi',
                  icon: Icon(Icons.dashboard),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Prodi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: semesterController,
                decoration: const InputDecoration(
                  hintText: 'Semester',
                  labelText: 'Semester',
                  icon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Semester tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'IPK',
                  labelText: 'IPK',
                  icon: Icon(Icons.score),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'IPK tidak boleh kosong';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" bukan angka yang valid';
                  }
                  if (n < 0 || n > 4) {
                    return 'IPK harus berada di antara 0 dan 4';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: validateInput,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(width: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(myFocusNode);
                    },
                    child: const Text('Fokus ke Nama'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
