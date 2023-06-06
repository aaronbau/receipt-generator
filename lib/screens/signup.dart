import 'package:flutter/material.dart';
import 'package:pluto/widgets/rt_button.dart';
import 'package:pluto/widgets/rt_text.dart';
import 'package:pluto/widgets/rt_text_button.dart';
import 'package:pluto/widgets/rt_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
    this.termsAccepted = false,
  }) : super(key: key);

  final bool termsAccepted;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool termsAccepted = false;
  int currentStep = 0;

  @override
  void initState() {
    termsAccepted = widget.termsAccepted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronic Official Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Stepper(
                  currentStep: currentStep,
                  onStepTapped: (newIndex) => setState(() => currentStep = newIndex),
                  onStepContinue: () => currentStep != 3 ? setState(() => currentStep += 1) : null,
                  onStepCancel: () => currentStep != 0 ? setState(() => currentStep -= 1) : null,
                  controlsBuilder: (BuildContext context, {void Function()? onStepContinue, void Function()? onStepCancel}) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          if (currentStep != 3)
                            RtButton(
                              text: 'Next',
                              onPressed: onStepContinue,
                              isMaxWidth: false,
                            )
                          else
                            RtButton(
                              text: 'Register',
                              onPressed: () async {
                                final response = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actions: [
                                      RtTextButton(
                                        text: 'OK',
                                        onPressed: () => Navigator.pop(context, true),
                                      ),
                                    ],
                                    content: RtText(
                                      text: 'You have successfully signed up.',
                                    ),
                                  ),
                                );
                                if (response) Navigator.pop(context);
                              },
                              isMaxWidth: false,
                            ),
                          SizedBox(width: 8),
                          if (currentStep != 0)
                            RtButton(
                              text: 'Back',
                              onPressed: onStepCancel,
                              isMaxWidth: false,
                            ),
                        ],
                      ),
                    );
                  },
                  steps: [
                    Step(
                      title: RtText(
                        text: 'Account Information',
                        isSubHeading: true,
                      ),
                      content: Column(
                        children: [
                          RtTextField(label: 'Email Address'),
                          SizedBox(height: 16),
                          RtTextField(
                            label: 'Password',
                            isPassword: true,
                          ),
                          SizedBox(height: 16),
                          RtTextField(
                            label: 'Confirm Password',
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: RtText(
                        text: 'User type',
                        isSubHeading: true,
                      ),
                      content: Column(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'User Type',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45),
                              ),
                            ),
                            onChanged: (_) {},
                            items: [
                              DropdownMenuItem(
                                value: 'Taxpayer',
                                child: Text('Taxpayer'),
                              ),
                              DropdownMenuItem(
                                value: 'BIR',
                                child: Text('BIR'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Step(
                      title: RtText(
                        text: 'User Information',
                        isSubHeading: true,
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            RtTextField(label: 'First Name'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Middle Initial'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Last Name'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Mobile Number'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Asset Code'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Property Index Number'),
                            SizedBox(height: 16),
                            RtTextField(label: 'Tax Declaration Number'),
                            SizedBox(height: 16),
                            RtTextField(label: 'LGU QR Code'),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Checkbox(
                                    value: termsAccepted,
                                    onChanged: (response) => (setState(() => termsAccepted = response!)),
                                  ),
                                ),
                                Expanded(
                                  child: RtText(text: 'I accept the Terms & Conditions and Privacy Policy'),
                                )
                              ],
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      title: RtText(
                        text: 'Sign Up',
                        isSubHeading: true,
                      ),
                      content: SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
