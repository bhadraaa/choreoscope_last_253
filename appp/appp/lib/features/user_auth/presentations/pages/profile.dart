import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'nav_key.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? username = '';
  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  void loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 1, 1),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              // Profile Picture
              CircleAvatar(
                radius: 50.0,
                child: Lottie.asset(
                  'assets/animations/Animation-1.json',
                  repeat: false,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                backgroundColor: const Color.fromARGB(221, 233, 204, 204),
              ),
              const SizedBox(height: 20.0),
              // Name
              Text(
                "Welcome  $username !",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),

              ElevatedButton.icon(
                onPressed: () {
                  history(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 142, 23, 15),
                ),
                icon: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: const Text(
                  'History',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  signout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 142, 23, 15),
                ),
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) {
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return MyLogin();
    }), (route) {
      return false;
    });
  }

  history(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: 600,
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    title: Text('image1 mudra'),
                    subtitle: Text('meaning '),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_next_rounded,
                        color: const Color.fromARGB(255, 144, 15, 15),
                      ),
                    ),
                    tileColor: const Color.fromARGB(255, 207, 163, 163),
                    textColor: Colors.black,
                  )
                ],
              ));
        });
  }
}
