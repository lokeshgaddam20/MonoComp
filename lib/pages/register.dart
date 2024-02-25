import 'package:flutter/material.dart';
import 'package:geminiai/components/mybutton.dart';
import 'package:geminiai/components/mytextfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Icon(Icons.account_circle_rounded,
              size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 50),
          Text("Let's Create an account for you!",
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
          MyTextField(
            hintText: "Confirm password",
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 10),
          MyButton(
            text: "Register",
            onTap: register,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text("Already have an account?",
                  style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: onTap,
                child: const Text("Login Now",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
