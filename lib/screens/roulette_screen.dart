import 'package:flutter/material.dart';
import 'dart:math';

class RouletteScreen extends StatefulWidget {
  @override
  _RouletteScreenState createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> with SingleTickerProviderStateMixin {
  final List<String> foodItems = [
    'Pizza',
    'Sushi',
    'Burger',
    'Salad',
    'Pasta',
    'Steak',
    'Ramen',
    'Tacos',
    'Curry',
    'Ice Cream'
  ];

  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0.0;
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ))..addListener(() {
      setState(() {
        _angle = _animation.value * 360 + _angle; // Incremental rotation
      });
    });
  }

  void _spinWheel() {
    if (_spinning) return;
    setState(() {
      _spinning = true;
    });
    final random = Random();
    final target = random.nextDouble() * 360 + 360 * 5; // Random end angle
    _controller.reset();
    _controller.forward().whenComplete(() {
      setState(() {
        _spinning = false;
        _angle += target; // Final angle after spin
      });
      final resultIndex = (_angle ~/ (360 / foodItems.length)) % foodItems.length;
      final result = foodItems[resultIndex];
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You got $result!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Roulette'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: _angle * (pi),
                    child: Image.asset(
                      'assets/images/roulette.png', // 동그라미 이미지
                      width: 560,
                      height: 560,
                    ),
                  ),
                  // 가운데 축을 표시할 수 있는 원형 위젯 (옵션)

                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text(_spinning ? 'Spinning...' : 'Spin the Wheel!'),
            ),
          ],
        ),
      ),
    );
  }
}
