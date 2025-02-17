import 'package:appp/features/user_auth/presentations/pages/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../user_auth/presentations/pages/login.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  User? user;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // Ensure Firebase is ready before using it
    WidgetsBinding.instance.addPostFrameCallback((_) {
      user = FirebaseAuth.instance.currentUser;
      navigateToLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 254, 253),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
          ),
        ),
      ),
    );
  }

  /// Function to navigate to the login screen
  Future<void> navigateToLogin() async {
    User? user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(seconds: 3)); // Splash delay

    if (user != null && user.emailVerified) {
      // If user is logged in and email is verified, go to Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Nav()), // Home screen
      );
    } else {
      // If not logged in, go to Login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const MyLogin()), // Login screen
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
