import 'dart:io';

import 'package:contect_diary/modals/contact_list.dart';
import 'package:contect_diary/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContectPage extends StatefulWidget {
  const AddContectPage({Key? key}) : super(key: key);

  @override
  State<AddContectPage> createState() => _AddContectPageState();
}

class _AddContectPageState extends State<AddContectPage> {
  final ImagePicker picker = ImagePicker();
  File? xfile;
  final GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String email = "";
  File? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (addContactFormKey.currentState!.validate()) {
                addContactFormKey.currentState!.save();
                Contact c1 = Contact(
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  email: email,
                  imgFile: imgFile!,
                );

                Globals.allContacts.add(c1);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
                setState(() {});
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade400,
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.black),
                    ),
                    foregroundImage:
                        (imgFile == null) ? null : FileImage(imgFile as File),
                  ),
                  FloatingActionButton(
                    mini: true,
                    child: Icon(Icons.camera_alt),
                    onPressed: () async {
                      ImagePicker picker = ImagePicker();
                      XFile? xFile =
                          await picker.pickImage(source: ImageSource.camera);
                      String path = xFile!.path;
                      setState(() {
                        imgFile = File(path);
                      });
                    },
                  ),
                  FloatingActionButton(
                    mini: true,
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                    ),
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Profile Photo",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            imgFile = null;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () async {
                                        final XFile? xfile =
                                            await picker.pickImage(
                                                source: ImageSource.camera);

                                        String imagePath = xfile!.path;
                                        setState(() {
                                          imgFile = File(imagePath);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    FloatingActionButton(
                                      onPressed: () async {
                                        final XFile? xfile =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);

                                        String imagePath = xfile!.path;
                                        setState(() {
                                          imgFile = File(imagePath);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(
                                        Icons.image,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: addContactFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter first name first...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          firstName = val!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter First name here..."),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Last Name"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Last name first...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          lastName = val!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter last name here..."),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Phone Number"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phonenumberController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Phone Number first...";
                          } else if (val!.length != 10) {
                            return "Enter 10 digit phone no..";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          phoneNumber = val!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Phone number here..."),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Email"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Email first...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          email = val!;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Email here..."),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
