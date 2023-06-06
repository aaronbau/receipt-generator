import 'package:flutter/material.dart';
import 'package:pluto/widgets/rt_button.dart';
import 'package:pluto/widgets/rt_text.dart';
import 'package:pluto/widgets/rt_text_button.dart';
import 'package:pluto/widgets/rt_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                      RtText(
                        text: 'eOR',
                        isHeader: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  RtTextField(
                    label: 'Username',
                    isRequired: true,
                    onChanged: (value) => setState(() => username = value),
                  ),
                  SizedBox(height: 16),
                  RtTextField(
                    label: 'Password',
                    isPassword: true,
                    isRequired: true,
                  ),
                  SizedBox(height: 16),
                  RtButton(
                    text: 'Login',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (username.toLowerCase().startsWith('bir'))
                          return Navigator.popAndPushNamed(context, '/bir/home');
                        else
                          return Navigator.popAndPushNamed(context, '/home');
                      }
                    },
                  ),
                  SizedBox(height: 32),
                  RtTextButton(
                    text: 'Register Now',
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                  ),
                  SizedBox(height: 8),
                  RtTextButton(text: 'Forgot Password?'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
