import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_page.dart';
import '../main_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCook = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

 void _login() async {
  if (_formKey.currentState!.validate()) {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final user = Supabase.instance.client.auth.currentUser;

      if (user != null && user.emailConfirmedAt == null) {
        await Supabase.instance.client.auth.signOut();

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Email non vérifié"),
            content: Text(
              "Veuillez vérifier votre adresse email (${user.email}) avant de vous connecter.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );

        return;
      }

      final profile = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', user!.id)
          .single();

      final cook = await Supabase.instance.client
          .from('cooks')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      final bool isCook = cook != null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bienvenue ${profile['prenom']}")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainLayout(isCook: isCook)),
      );
    } on Exception catch (exception)  {
      print('Unknown exception: $exception');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email ou mot de passe incorrect")),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Au Fourneau",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) =>
                      value!.isEmpty ? "Veuillez entrer votre email" : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Mot de passe"),
                  validator: (value) =>
                      value!.isEmpty ? "Veuillez entrer un mot de passe" : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text("Se connecter"),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text("Créer un compte"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
