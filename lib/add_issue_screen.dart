import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grievance_app/utils/firebase_operations.dart';

import 'home_screen.dart';

class AddIssueScreen extends StatefulWidget {
  const AddIssueScreen({Key? key}) : super(key: key);

  @override
  State<AddIssueScreen> createState() => _AddIssueScreenState();
}

class _AddIssueScreenState extends State<AddIssueScreen> {
  final _formKey = GlobalKey<FormState>();
  late String issue;
  late String description;
  late final List<String> errors = [];
  FocusNode subjectNumberFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

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
                    child: Center(child: Text("Add Issue", style: TextStyle(
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
                        buildIssueSubjectFormField(),
                        SizedBox(height: 20.0,),
                        buildDescriptionFormField(),
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
                            child: Text("Add", style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FirebaseOperation.addIssue(issue, description);
                              // if all are valid then go to success screen
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

  TextFormField buildIssueSubjectFormField() {
    return TextFormField(
      focusNode: subjectNumberFocusNode,
      onSaved: (newValue) => issue = newValue!,
      onTap: _requestSubjectFocus,
      decoration: InputDecoration(
        labelText: "Issue Subject",
        labelStyle: TextStyle(
            color: subjectNumberFocusNode.hasFocus ? Colors.blue : Colors.black
        ),
        hintText: "Enter subject for the issue",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_rounded, color: subjectNumberFocusNode.hasFocus ? Colors.blue : Colors.black,),
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      focusNode: descriptionFocusNode,
      onSaved: (newValue) => description = newValue!,
      onTap: _requestDescriptionFocus,
      decoration: InputDecoration(
        labelText: "Description",
        labelStyle: TextStyle(
            color: descriptionFocusNode.hasFocus ? Colors.blue : Colors.black
        ),
        hintText: "Explain the issue as detailed as possible",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.chat_rounded, color: descriptionFocusNode.hasFocus ? Colors.blue : Colors.black,),
      ),
    );
    // return TextFormField(
    //   onSaved: (newValue) => description = newValue!,
    //   keyboardType: TextInputType.text,
    //   onTap: _requestDescriptionFocus,
    //   decoration: InputDecoration(
    //     labelText: "Description",
    //     labelStyle: TextStyle(
    //         color: descriptionFocusNode.hasFocus ? Colors.blue : Colors.black
    //     ),
    //     hintText: "Explain the issue as detailed as possible",
    //     border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10.0)
    //     ),
    //     floatingLabelBehavior: FloatingLabelBehavior.always,
    //     suffixIcon: Icon(Icons.chat_rounded, color: descriptionFocusNode.hasFocus ? Colors.blue : Colors.black,),
    //   ),
    // );
  }

  void _requestSubjectFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(subjectNumberFocusNode);
    });
  }

  void _requestDescriptionFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(descriptionFocusNode);
    });
  }
}
