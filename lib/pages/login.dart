import 'package:flutter/material.dart';
import 'package:geminiai/auth/auth_provider.dart';
import 'package:geminiai/components/mybutton.dart';
import 'package:geminiai/components/mytextfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authProvider = AuthProvider();
    try {
      await authProvider.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message,
                size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 50),
            Text("Welcome Back, Glad to see you!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16)),
            const SizedBox(height: 20),
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
              onTap: () => login(context),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member?", style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text("Register Now",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
