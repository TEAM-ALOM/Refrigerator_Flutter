import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';

import '../colors.dart';

import 'package:http/http.dart' as http;

String myToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsZWVzb3BoeTA4MDVAZ21haWwuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTcyNjY3MDg5NiwiZXhwIjoxNzU4MjA4Njk2fQ.l-cXO6_y4DofA10o6R7EspNjd6Vq_rJNh8VUX3bd4g1pHaoAkJkpU6OFyMsaqRE7BYlufsMh8KnPtdcvaINx_g";


Future<void> goToRecipe(String menu) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/ingredients');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
      },
    );



    if (response.statusCode == 200) {
      print(response.body); // 성공적인 응답
    } else {
      print('Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
    }
  } catch (e) {
    print('Error: ${e.toString()}'); // 예외 발생 시
  }
}



class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  _RouletteScreenState createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  final List<String> foodItems = [
    '김치볶음밥',
    '알리오 올리오',
    '스파게티',
    '김치찌개',
    '제육볶음',
    '카레',
    '피자',
    '초밥',
    '햄버거',
    '샐러드',
    '파스타',
    '스테이크',
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
      duration: const Duration(seconds: 1), // 스핀 지속 시간
      vsync: this,
    );

    // 애니메이션 설정
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // 점점 느려지는 애니메이션
    ))
      ..addListener(() {
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
      final resultIndex = Random().nextInt(foodItems.length);
      final result = foodItems[resultIndex];

      // 결과 다이얼로그 표시
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              result,
              style: TextStyle(color: rouletteBlue, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: (){
                goToRecipe("감자국수");
                print("check");
              },
              child: Text('레시피 보러가기',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
          backgroundColor: rouletteSky,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: rouletteBlue),
              ),
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
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: HexColor('#E3E3E3'),
        shape: Border(bottom: BorderSide(color: HexColor('#E3E3E3'))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "오늘의 메뉴는?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 100),
          Transform.translate(
            offset: const Offset(0, 200),
            child: SizedBox(
              width: 500,
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                      angle: _angle * (pi / 180), // 각도를 라디안으로 변환
                      child: GestureDetector(
                        onTap: _spinWheel,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/roulette.png', // 동그라미 이미지
                            width: 500,
                            height: 500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
