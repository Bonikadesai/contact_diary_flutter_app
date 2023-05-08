import 'package:flutter/material.dart';

class EditcontactPage extends StatefulWidget {
  const EditcontactPage({Key? key}) : super(key: key);

  @override
  State<EditcontactPage> createState() => _EditcontactPageState();
}

class _EditcontactPageState extends State<EditcontactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Contact",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done),
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(),
    );
  }
}
