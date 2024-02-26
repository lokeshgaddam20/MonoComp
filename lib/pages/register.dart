import 'package:flutter/material.dart';
import 'package:geminiai/auth/auth_provider.dart';
import 'package:geminiai/components/mybutton.dart';
import 'package:geminiai/components/mytextfield.dart';
import 'package:random_string/random_string.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final authService = AuthService();
    if (passwordController.text == confirmController.text) {
      try {
        authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);

        String id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfo = {
          "email": emailController.text,
          "password": passwordController.text,
          "id": id,
        };
        authService.addUserInfo(userInfo, id);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match!"),
                contentPadding: EdgeInsets.all(20),
              ));
      passwordController.text = "";
      confirmController.text = "";
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
            Icon(Icons.account_circle_rounded,
                size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 50),
            Text("Let's Create an account for you!",
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
            MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: confirmController,
            ),
            const SizedBox(height: 10),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",
                      style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text("Login Now",
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
