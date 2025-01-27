import 'package:flutter/material.dart';
import '../../user_auth/presentations/pages/login.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );

    // Define a fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Smooth fade-in curve
      ),
    );

    // Start the animation
    _animationController.forward();

    // Navigate to the login screen after a delay
    navigateToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 254, 253),
        child: Center(
          // Fade transition for the logo
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/images/logo.png', // Make sure this image exists
              height: 150,
            ),
          ),
        ),
      ),
    );
  }

  /// Function to navigate to the login screen
  Future<void> navigateToLogin() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Wait for the splash to show
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MyLogin()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }
}
