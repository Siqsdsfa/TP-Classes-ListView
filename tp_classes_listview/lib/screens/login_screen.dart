import 'package:tp_classes_listview/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String name = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool hidePass = true;
  bool succesfulLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(height: 80),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage("https://i.ibb.co/fXjRwdv/foto.png"),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                loginTextField(
                  'Mail',
                  const Icon(Icons.person_rounded, color: Colors.white),
                  mailController,
                  false,
                ),
                const SizedBox(height: 25),
                loginTextField(
                  'Password',
                  const Icon(Icons.person_rounded, color: Colors.white),
                  passController,
                  true,
                ),
                const SizedBox(height: 80),
                checkLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => hidePass = !hidePass);

  Widget loginTextField(String title, Icon icon,
      TextEditingController controller, bool isPasswordField) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        labelText: title,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: icon,
        suffixIcon: isPasswordField != false
            ? IconButton(
                icon: hidePass
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: togglePasswordVisibility,
                color: Colors.white,
              )
            : null,
      ),
      controller: controller,
      obscureText: isPasswordField != false ? hidePass : false,
    );
  }

  Widget checkLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        handleLogin();
      },
    );
  }

  void handleLogin() {
    String mail = mailController.text;
    String pass = passController.text;
    if (mail.isEmpty || pass.isEmpty) {
      createSnackBar('Mail or password not filled');
    } else {
      //credentialUserData.forEach((element) { });
      for (var element in credentialUserData) {
        if (element.email == mail && element.password == pass) {
          createSnackBar('Succesful Login');
          succesfulLogin = true;
          context.pushNamed(HomeScreen.name, extra: mailController.text);
        }
      }
      if (succesfulLogin == false) {
        createSnackBar('Failed Login');
        passController.clear();
      }
    }
  }

  void createSnackBar(String text) {
    debugPrint(text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

class CredentialUserData {
  final String email;
  final String password;
  CredentialUserData({
    required this.email,
    required this.password,
  });
}

List<CredentialUserData> credentialUserData = [
  CredentialUserData(
    email: 'jorge@gmail.com',
    password: 'Jorge123',
  ),
  CredentialUserData(
    email: 'mateo@gmail.com',
    password: 'Mat3o',
  ),
  CredentialUserData(
    email: 'alicesmith@outlook.com',
    password: 'alice123',
  ),
  CredentialUserData(
    email: 'bobjohnson@gmail.com',
    password: 'bob12345',
  ),
  CredentialUserData(
    email: 'carolwilliams@outlook.com',
    password: 'carol678',
  ),
  CredentialUserData(
    email: 'davidbrown@gmail.com',
    password: 'david910',
  ),
  CredentialUserData(
    email: 'evejones@outlook.com',
    password: 'eve234',
  ),
  CredentialUserData(
    email: 'frankgarcia@gmail.com',
    password: 'frank567',
  ),
  CredentialUserData(
    email: 'gracemartinez@outlook.com',
    password: 'grace890',
  ),
  CredentialUserData(
    email: 'hankdavis@gmail.com',
    password: 'hank112',
  ),
  CredentialUserData(
    email: 'ivyrodriguez@outlook.com',
    password: 'ivy334',
  ),
  CredentialUserData(
    email: 'jackwilson@gmail.com',
    password: 'jack556',
  ),
];