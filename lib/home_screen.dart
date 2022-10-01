import 'package:flutter/material.dart';
import 'package:grievance_app/add_issue_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddIssueScreen()));
        },
        tooltip: 'Add Issue',
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text("No Requests", style: TextStyle(
              fontSize: 22.0
            ),),
          )
        ),
      ),
    );
  }
}
