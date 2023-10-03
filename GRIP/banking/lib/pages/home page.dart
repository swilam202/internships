import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController fadeAnimationController;
  late AnimationController buttonFadeAnimationController;
  late AnimationController slideAnimationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> buttonFadeAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    fadeAnimationController.dispose();
    slideAnimationController.dispose();
    buttonFadeAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bank.gif'),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(blurRadius: 120, color: Colors.grey),
                BoxShadow(blurRadius: 120, color: Colors.amber),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Align(
                alignment: Alignment.center,
                child: SlideTransition(
                  position: slideAnimation,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome to Mint the fastest online Banking system',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          FadeTransition(
            opacity: buttonFadeAnimation,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(8),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Colors.amber),
                backgroundColor: MaterialStateProperty.all(Colors.yellow[500]),
                animationDuration: const Duration(seconds: 5),
              ),
              label: const Text(
                'Select Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.forward),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void initAnimation() {
    fadeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    slideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    buttonFadeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fadeAnimation =
        Tween<double>(begin: 0.1, end: 1.0).animate(fadeAnimationController);
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 3), end: const Offset(0, 1))
            .animate(slideAnimationController);
    buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(buttonFadeAnimationController);

    slideAnimationController.forward().then((_) => fadeAnimationController
        .forward()
        .then((_) => buttonFadeAnimationController.forward()));
  }
}
