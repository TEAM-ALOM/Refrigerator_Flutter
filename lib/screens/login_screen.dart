import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';
import 'package:refrigerator_frontend/screens/sign_in_screen.dart';
import 'package:refrigerator_frontend/widgets/custom_textformfield.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 로그인 화면
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String _token = '';

  Uri url = Uri.parse('http://43.201.84.66:8080/api/login');
  // 로그인 함수
  Future<void> login() async {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final accessToken = data['authToken']['accessToken'];
      final refreshToken = data['authToken']['refreshToken'];

      // print('accessToken : $accessToken');
      // print(refreshToken);

      if (accessToken != null && refreshToken != null) {
        // 토큰 저장
        await saveTokens(accessToken, refreshToken);
      }
      setState(() {
        _token = data['authToken']['accessToken']; // 토큰 저장
      });
      // 로그인 성공
      print('로그인 성공, 토큰: $_token');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else {
      print('로그인 실패, ${response.statusCode}');
      showAboutDialog(context: context, children: [const Text('없는 아이디입니다람쥐')]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Image.asset(
                'assets/images/logo_with_icon.png',
                height: 300,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28.0),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                            color: txtColor_1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CookieRun'),
                      ),
                    ),
                    CustomTextFormField(
                      hintText: '이메일 / 닉네임',
                      obscureText: false,
                      sufficIcon: null,
                      onChanged: (newValue) {
                        setState(() {
                          email = newValue;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) return '닉네임을 입력하세요';
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    CustomTextFormField(
                      hintText: '비밀번호',
                      obscureText: true,
                      sufficIcon: null,
                      onChanged: (newValue) {
                        setState(() {
                          password = newValue;
                        });
                      },
                      validator: (value) {
                        String pattern =
                            r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
                        RegExp regExp = RegExp(pattern);

                        if (value.isEmpty) {
                          return '비밀번호를 입력하세요';
                        } else if (value.length < 8) {
                          return '비밀번호는 8자리 이상이어야 합니다';
                        } else if (!regExp.hasMatch(value)) {
                          return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
                        } else {
                          return null; //null을 반환하면 정상
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    '로그인',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  login();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                );
              },
              child: Text(
                '회원가입',
                style: TextStyle(
                  color: txtColor_2,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
