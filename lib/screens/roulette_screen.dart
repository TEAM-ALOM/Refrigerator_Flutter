import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hexcolor/hexcolor.dart';

import '../colors.dart';

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
  double _angle = 0.0; // 누적 각도
  double _currentAngle = 0.0; // 현재까지의 각도
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // 스핀 지속 시간
      vsync: this,
    );

    // 애니메이션 설정
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // 점점 느려지는 애니메이션
    ))..addListener(() {
      setState(() {
        // 5바퀴 돌리기
        _angle = _animation.value * 360 * 10; // 5바퀴 돌도록 각도 설정
      });
    });
  }

  void _spinWheel() {
    if (_spinning) return;
    setState(() {
      _spinning = true;
    });

    _controller.reset();
    _controller.forward().whenComplete(() {
      setState(() {
        _spinning = false;
        _currentAngle += _angle; // 누적 각도 계산
      });

      // 결과 계산
      final resultIndex = (_currentAngle ~/ (360 / foodItems.length)) % foodItems.length;
      final result = foodItems[resultIndex];

      // 결과 다이얼로그 표시
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

        title: Image.asset(
          'assets/images/logo.png',
          width: 137,
          height: 137,
        ),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: _spinWheel,
              child: Text(_spinning ? 'Spinning...' : 'Spin the Wheel!'),
            ),
            SizedBox(height: 50),
            Transform.translate(offset: Offset(0,250),
            child: Container(
              width: 500,
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: _angle * (pi / 180), // 각도를 라디안으로 변환
                    child: Image.asset(
                      'assets/images/roulette.png', // 동그라미 이미지
                      width: 900,
                      height: 900,
                    ),
                  ),
                ],
              ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}
