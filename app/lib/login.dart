import 'package:app/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();

  final ValueNotifier<bool> nameNoti = ValueNotifier(true);
  final ValueNotifier<bool> emailNoti = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 230, 230, 230),
          child: Column(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: nameNoti,
                builder: (context, isValid, _) {
                  return isValid
                      ? const SizedBox.shrink()
                      : const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "User Name is required",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: userName,
                  onChanged: (value) => nameNoti.value = value.isNotEmpty,
                  decoration: InputDecoration(
                    hintText: "UserName",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ValueListenableBuilder<bool>(
                valueListenable: emailNoti,
                builder: (context, isValid, _) {
                  return isValid
                      ? const SizedBox.shrink()
                      : const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Email is required",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  onChanged: (value) => emailNoti.value = value.isNotEmpty,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  validate(userName.text, email.text, context);
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate(String name, String email, BuildContext ctx) async {
    nameNoti.value = name.isNotEmpty;
    emailNoti.value = email.isNotEmpty;
    emailNoti.value = email.contains("@");

    if (name.isNotEmpty && email.isNotEmpty) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("user_name", name);
      sharedPreferences.setString("email", email);
      sharedPreferences.setBool("isLoggin", true);
      if (email.contains("@") == true) {
        Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }
}
