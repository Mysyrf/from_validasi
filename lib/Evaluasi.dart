import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validasi Form',
      home: const FormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String role = '0'; // Default ke User

  InputDecoration buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 4 || value.length > 25) {
      return 'Panjang username 4–25 karakter';
    }
    if (RegExp(r'\d').hasMatch(value)) {
      return 'Username tidak boleh mengandung angka';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }
    if (!RegExp(r'^\d{10,12}$').hasMatch(value)) {
      return 'Nomor HP harus 10–12 digit angka';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 4 || value.length > 25) {
      return 'Panjang password 4–25 karakter';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Data Valid'),
            content: Text(
              'Username: ${usernameController.text}\n'
              'Email: ${emailController.text}\n'
              'No HP: ${phoneController.text}\n'
              'Role: ${role == '0' ? 'User' : 'Admin'}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blue,
        title: const Text('Form Validasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: buildInputDecoration('Username', Icons.person),
                validator: validateUsername,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: buildInputDecoration('Email', Icons.email),
                validator: validateEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: buildInputDecoration('Nomor HP', Icons.phone),
                keyboardType: TextInputType.number,
                validator: validatePhone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: buildInputDecoration('Password', Icons.lock),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: confirmPasswordController,
                decoration: buildInputDecoration('Confirm Password', Icons.lock_outline),
                obscureText: true,
                validator: validateConfirmPassword,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: '0', child: Text('User')),
                  DropdownMenuItem(value: '1', child: Text('Admin')),
                ],
                onChanged: (value) {
                  setState(() {
                    role = value!;
                  });
                },
                decoration: buildInputDecoration('Role', Icons.group),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
               style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ), 
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
