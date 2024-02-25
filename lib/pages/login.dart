import 'package:flutter/material.dart';
import 'package:geminiai/components/mybutton.dart';
import 'package:geminiai/components/mytextfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Icon(Icons.message,
              size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 50),
          Text("Welcome Back",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16)),
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: emailController,
          ),
          const SizedBox(height: 10),
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 10),
          MyButton(
            text: "Login",
            onTap: login,
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Text("Not a member?", style: TextStyle(fontSize: 16)),
              Text("Register Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
