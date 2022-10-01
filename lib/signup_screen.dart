import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grievance_app/home_screen.dart';

import 'constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late String mobile;
  late String password;
  late final List<String> errors = [];
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    width: double.infinity,
                    child: Center(child: Text("Signup", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0
                    ),))
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // TODO: Refer to designs and make it a less rounded and non-floating design
                        buildMobileFormField(),
                        SizedBox(height: 20.0,),
                        buildPasswordFormField(),
                        SizedBox(height: 16.0,),
                        RichText(
                          text: TextSpan(
                              text: "Already having an Account? ",
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                                )
                              ],
                              style:
                              TextStyle(color: Colors.black, fontSize: 13)),
                        ),
                        SizedBox(height: 40.0,),
                        // Add width factor to the TextButton
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: BorderSide(color: Colors.blueAccent)
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Text("Register", style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // if all are valid then go to success screen
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      focusNode: mobileNumberFocusNode,
      onSaved: (newValue) => mobile = newValue!,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileShortError);
        } else if (value.length == 10) {
          removeError(error: kMobileShortError);
        } else if (isValidMobile(value)) {
          removeError(error: kMobileSpecialError);
        }
        mobile = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (value.length > 10 || value.length < 10) {
          addError(error: kMobileShortError);
          return "";
        } else if (!isValidMobile(value)) {
          addError(error: kMobileSpecialError);
          return "";
        }
        return null;
      },
      onTap: _requestMobileFocus,
      decoration: InputDecoration(
        labelText: "Mobile Number",
        labelStyle: TextStyle(
            color: mobileNumberFocusNode.hasFocus ? Colors.blue : Colors.black
        ),
        hintText: "Enter your mobile number",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_rounded, color: mobileNumberFocusNode.hasFocus ? Colors.blue : Colors.black,),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileShortError);
        } else if (value.length == 10) {
          removeError(error: kMobileShortError);
        } else if (isValidMobile(value)) {
          removeError(error: kMobileSpecialError);
        }
        mobile = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (value.length > 10 || value.length < 10) {
          addError(error: kMobileShortError);
          return "";
        } else if (!isValidMobile(value)) {
          addError(error: kMobileSpecialError);
          return "";
        }
        return null;
      },
      onTap: _requestPasswordFocus,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
            color: passwordFocusNode.hasFocus ? Colors.blue : Colors.black
        ),
        hintText: "Enter password",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock, color: passwordFocusNode.hasFocus ? Colors.blue : Colors.black,),
      ),
    );
  }

  bool isValidMobile(String? mobile) {
    if(mobile == null) {
      return false;
    }
    return double.tryParse(mobile) != null;
  }

  void _requestMobileFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(mobileNumberFocusNode);
    });
  }

  void _requestPasswordFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }
}