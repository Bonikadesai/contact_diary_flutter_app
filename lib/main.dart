import 'package:contect_diary/utils/app_theme.dart';
import 'package:contect_diary/utils/globals.dart';
import 'package:contect_diary/views/screens/add_contact_page.dart';
import 'package:contect_diary/views/screens/contact_page.dart';
import 'package:contect_diary/views/screens/edit_page.dart';
import 'package:contect_diary/views/screens/splsh_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.red,
  //   systemNavigationBarColor:
  // ));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: AppTheme.darkTheme,
      themeMode: (isDark) ? ThemeMode.dark : ThemeMode.light,
      initialRoute: 'splsh_screen',
      routes: {
        'add_contact_page': (context) => AddContectPage(),
        'contact_page': (context) => ContactPage(),
        'splsh_screen': (context) => SplashScreen(),
        'edit_page': (context) => EditcontactPage(),
        '/': (context) => Scaffold(
              appBar: AppBar(
                title: const Text("Contacts"),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon: Icon(Icons.sunny),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.more_vert,
                    ),
                  ),
                ],
              ),
              body: (Globals.allContacts.isNotEmpty)
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: Globals.allContacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed('contact_page',
                                arguments: Globals.allContacts[index]);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            foregroundImage:
                                FileImage(Globals.allContacts[index].imgFile),
                          ),
                          title: Text(
                              "${Globals.allContacts[index].firstName} ${Globals.allContacts[index].lastName}"),
                          subtitle: Text(
                              "+91 ${Globals.allContacts[index].phoneNumber}"),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            onPressed: () {},
                          ),
                        );
                      })
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.card_travel_rounded,
                            size: 100,
                          ),
                          Text(
                            "You have no contacts yet",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed("add_contact_page");
                },
              ),
            ),
      },
    );
  }
}
