import 'dart:io';

import 'package:contect_diary/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modals/contact_list.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  File? xfile;
  @override
  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;
    var imgFile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 75, bottom: 25, left: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 60,
                  foregroundImage: FileImage(contact.imgFile),
                ),
                IconButton(
                  onPressed: () async {
                    Globals.allContacts.remove(contact);
                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('edit_page');
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
          Text(
            "${contact.firstName} ${contact.lastName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25, right: 200),
            child: Text(
              "+91 ${contact.phoneNumber}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  child: Icon(
                    Icons.phone,
                  ),
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    String c = "tel:+91 ${contact.phoneNumber}";
                    await launchUrl(Uri.parse(c));
                  },
                ),
                FloatingActionButton(
                    child: Icon(
                      Icons.message,
                    ),
                    backgroundColor: Colors.amber,
                    onPressed: () async {
                      String c = "sms:+91 ${contact.phoneNumber}";
                      await launchUrl(Uri.parse(c));
                    }),
                FloatingActionButton(
                    child: Icon(
                      Icons.email,
                    ),
                    backgroundColor: Colors.lightBlueAccent,
                    onPressed: () async {
                      String c = "mailto:+91 ${contact.email}";
                      await launchUrl(Uri.parse(c));
                    }),
                FloatingActionButton(
                    child: Icon(
                      Icons.share_outlined,
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                    onPressed: () async {
                      await Share.share(
                          "${contact.firstName}${contact.phoneNumber}");
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
