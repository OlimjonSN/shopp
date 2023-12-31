// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopp/features/auth/presentation/providers/auth_provider.dart';
import 'package:shopp/features/shopp/presentation/widgets/yellow_button.dart';

import '../../../../config/router/routes.dart';
import '../widgets/stattus_message_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF3E7E7),
      body: Stack(
        fit: StackFit.expand,
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
                  ],
                ),
                const SizedBox(height: 16.0),
                YellowButton(title: 'Login', onTap: loginFunc),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Don\'t have an account? ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteGenerator.register);
                    },
                    child: const Text('Sign up', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)),
                  ),
                ]),
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
        hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        suffixIcon: hint == 'Password'
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
            : null);
  }

  void loginFunc() async {
    // TODO: Check user has entered data correctly
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isAdmin = await authProvider.login(emailController.text, passwordController.text);
    if (isAdmin && authProvider.status == Status.authenticated) {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.categoyAdmin, (route) => false);
    } else if (authProvider.status == Status.authenticated) {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.home, (route) => false);
    }
  }
}
