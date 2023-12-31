// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/config/router/routes.dart';
import 'package:shopp/features/auth/presentation/widgets/stattus_message_builder.dart';
import 'package:shopp/features/shopp/presentation/widgets/yellow_button.dart';

import '../providers/auth_provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordController2 = TextEditingController();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E7E7),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/wandarLogo.png', height: MediaQuery.of(context).size.height * 0.3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFieldName('Email or Username'),
                    TextField(
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                      cursorColor: const Color(0xFF6E75A8),
                      controller: emailController,
                      decoration: textfieldDecoration(Icons.email, 'Email@mail.ru'),
                    ),
                    const SizedBox(height: 16.0),
                    textFieldName('Password'),
                    TextField(
                      cursorColor: const Color(0xFF6E75A8),
                      controller: passwordController,
                      decoration: textfieldDecoration(Icons.lock, 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    textFieldName('reenter Password'),
                    TextField(
                      cursorColor: const Color(0xFF6E75A8),
                      controller: passwordController2,
                      decoration: textfieldDecoration(Icons.lock, 'reenter Password'),
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                YellowButton(title: 'Sign up', onTap: registerFunc),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('already have a account ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14)), TextButton(onPressed: () {}, child: const Text('Sign in', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)))]),
              ],
            ),
          ),
          const StatusMessageBuilder(),
        ],
      ),
    );
  }

  Padding textFieldName(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14)),
    );
  }

  InputDecoration textfieldDecoration(icon, String hint) {
    return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1.5, color: Color(0xFFFF9A62)), borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 3, color: Color(0xFFFF9A62)), borderRadius: BorderRadius.circular(20)),
        errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 3, color: Colors.red), borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        suffix: hint == 'Password'
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ))
            : null,
        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600));
  }

  void registerFunc() async {
    // TODO: Check before registering that user passwords are correct and not empty
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isAdmin = await authProvider.register(emailController.text, passwordController.text);
    if (isAdmin && authProvider.status == Status.authenticated) {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.categoyAdmin, (route) => false);
    } else if (authProvider.status == Status.authenticated) {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.home, (route) => false);
    }
  }
}
