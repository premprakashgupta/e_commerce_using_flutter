import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/firebase/authentication.dart';
import 'package:e_commerce_app/firebase/firebase_instance.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:e_commerce_app/utils/alert.dart';
import 'package:e_commerce_app/utils/media_query.dart';

import 'package:e_commerce_app/widget/heading_text.dart';

import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _globelKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.background,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _globelKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: HeadingText(
                    text: "Sign in",
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email@email.com',
                      label: Text('Email'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Xyz123#',
                      label: Text('Password'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forget your password?"),
                    ),
                    const Icon(Icons.arrow_right_alt_rounded)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text("New User?"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.btncolor,
                    fixedSize: Size(CustomMediaQuery(context).width * .8, 40),
                  ),
                  onPressed: () async {
                    try {
                      if (_globelKey.currentState!.validate()) {
                        String? res = await AuthenticationClass().signin(
                            email: emailController.text,
                            password: passwordController.text);
                        print(res);
                      }
                    } on FirebaseException catch (e) {
                      CustomAlert(context: context)
                          .error(error: e.message.toString());
                    }
                  },
                  child: Text('Login'),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Or login with social media',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                      'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
