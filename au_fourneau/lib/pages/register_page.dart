import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _villeController = TextEditingController();

  void _register() async {
  if (_formKey.currentState!.validate()) {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
        data: {
          'nom': _nomController.text,
          'prenom': _prenomController.text,
          'ville': _villeController.text,
        },
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Un email de confirmation a été envoyé à ${_emailController.text}. Vérifiez votre boîte mail",
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'inscription")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer un email" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Mot de passe"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer un mot de passe" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: "Prénom"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre prénom" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _villeController,
                decoration: const InputDecoration(labelText: "Ville"),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre ville" : null,
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
