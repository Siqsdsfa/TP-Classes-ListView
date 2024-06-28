import 'package:to_do_list/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String name = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  
  bool hidePass = true;
  String errorText = '';
  bool succesfulLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            backgroundImage: NetworkImage(
                                "https://i.ibb.co/fXjRwdv/foto.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextField(
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
                      labelText: 'User',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                    ),
                    controller: userController,
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: hidePass,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.key, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: hidePass
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: togglePasswordVisibility,
                        color: Colors.white,
                      ),
                    ),
                    controller: passController,
                  ),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          String user = userController.text;
                          String pass = passController.text;
                          if (user.isEmpty || pass.isEmpty) {
                            debugPrint('User or password not filled');
                            setState(() =>
                                errorText = 'User or password not filled');
                          } else {
                            //credentialUserData.forEach((element) { });
                            for (var element in credentialUserData) {
                              if (element.username == user &&
                                  element.password == pass) {
                                debugPrint('Succesful Login');
                                succesfulLogin = true;
                                context.pushNamed(HomeScreen.name,
                                    extra: userController.text);
                              }
                            }
                            if (succesfulLogin == false) {
                              debugPrint('Failed Login');
                              setState(() => errorText = 'Failed Login');
                              passController.clear();
                            }
                          }
                        },
                      ),
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => hidePass = !hidePass);
}

class CredentialUserData {
  final String username;
  final String password;
  CredentialUserData({
    required this.username,
    required this.password,
  });
}

List<CredentialUserData> credentialUserData = [
  CredentialUserData(
    username: 'Jorge',
    password: 'Jorge123',
  ),
  CredentialUserData(
    username: 'Mateo',
    password: 'Mat3o',
  ),
  CredentialUserData(
    username: 'AliceSmith',
    password: 'alice123',
  ),
  CredentialUserData(
    username: 'BobJohnson',
    password: 'bob12345',
  ),
  CredentialUserData(
    username: 'CarolWilliams',
    password: 'carol678',
  ),
  CredentialUserData(
    username: 'DavidBrown',
    password: 'david910',
  ),
  CredentialUserData(
    username: 'EveJones',
    password: 'eve234',
  ),
  CredentialUserData(
    username: 'FrankGarcia',
    password: 'frank567',
  ),
  CredentialUserData(
    username: 'GraceMartinez',
    password: 'grace890',
  ),
  CredentialUserData(
    username: 'HankDavis',
    password: 'hank112',
  ),
  CredentialUserData(
    username: 'IvyRodriguez',
    password: 'ivy334',
  ),
  CredentialUserData(
    username: 'JackWilson',
    password: 'jack556',
  ),
];
