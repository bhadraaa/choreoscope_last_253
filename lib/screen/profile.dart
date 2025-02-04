import 'package:flutter/material.dart';
import '../features/user_auth/presentations/pages/login.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatelessWidget {
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
              // Profile Picture
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKNHRh9kU6nD5_t6MWuSqABOSSN2UeqCTqTA&s", // Replace with a valid image URL
                ),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 20.0),
              // Name
              const Text(
                'Your Name',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              // Additional Info
              const Text(
                'yourname@example.com',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 55, 47, 47),
                ),
              ),
              const SizedBox(height: 30.0),

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
                height: 40,
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

  history(BuildContext ctx) {}
}
