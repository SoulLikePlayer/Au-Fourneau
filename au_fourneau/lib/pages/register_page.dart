import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/local_database.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _villeController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      final exists = LocalDatabase.getUsers().any(
        (u) => u.nom.toLowerCase() == _nomController.text.toLowerCase(),
      );

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ce nom est déjà utilisé")),
        );
        return;
      }

      final user = User(
        nom: _nomController.text,
        prenom: _prenomController.text,
        ville: _villeController.text,
      );

      LocalDatabase.addUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compte créé avec succès")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer un nom" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: "Prénom"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer un prénom" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _villeController,
                decoration: const InputDecoration(labelText: "Ville"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer une ville" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
