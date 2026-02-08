import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Website',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _logoPosition = const Offset(100.0, 100.0);
  Offset _velocity = const Offset(2.0, 1.5);
  Color _currentColor = Colors.blue;
  final Random _random = Random();
  Size? _screenSize;
  Timer? _animationTimer;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.cyan,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _startAnimation();
    });
  }

  void _startAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) return;

      setState(() {
        double newX = _logoPosition.dx + _velocity.dx;
        double newY = _logoPosition.dy + _velocity.dy;

        bool bounced = false;

        if (newX <= 0 || newX >= _screenSize!.width - 80) {
          _velocity = Offset(-_velocity.dx, _velocity.dy);
          newX = newX <= 0 ? 0 : _screenSize!.width - 80;
          bounced = true;
        }

        if (newY <= 0 || newY >= _screenSize!.height - 80) {
          _velocity = Offset(_velocity.dx, -_velocity.dy);
          newY = newY <= 0 ? 0 : _screenSize!.height - 80;
          bounced = true;
        }

        _logoPosition = Offset(newX, newY);

        if (bounced) {
          _currentColor = _colors[_random.nextInt(_colors.length)];
        }
      });
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: _logoPosition.dx,
            top: _logoPosition.dy,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: _currentColor.withOpacity(0.7),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
                border: Border.all(color: _currentColor, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37),
                child: Image.asset(
                  'assets/images/elon_musk.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.web, size: 80, color: Colors.white54),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Flutter Web',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Watch Elon Musk bounce around like a DVD screensaver',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Enter Website',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter Website'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to My Flutter Website',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'This is a basic Flutter website built with Material Design.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Flutter allows you to build beautiful web applications using a single codebase.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Cross-platform development'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Beautiful Material Design UI'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text('Fast development with hot reload'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
