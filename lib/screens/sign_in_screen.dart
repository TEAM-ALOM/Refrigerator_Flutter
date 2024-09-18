import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';
import 'package:refrigerator_frontend/widgets/custom_textformfield.dart';
import 'package:refrigerator_frontend/widgets/duplication_check_button.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //  회원가입 화면
  final formKey = GlobalKey<FormState>();
  final formKey_email = GlobalKey<FormState>();
  final formKey_nickname = GlobalKey<FormState>();
  final formKey_password = GlobalKey<FormState>();
  String email = '';
  String nickname = '';
  String password = '';

  // 회원가입 함수
  Future<void> signin() async {
    Uri url = Uri.parse('http://43.201.84.66:8080/api/sign-up');

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'password': password,
        'nickname': nickname,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('회원가입 성공, ${response.statusCode}');
      Navigator.pop(context);
    } else {
      print('회원가입 실패${response.statusCode}');
    }
  }

  // 이메일 중복 확인
  Future<void> emailCheck() async {
    Uri url = Uri.parse('http://43.201.84.66:8080/api/check/email');
    try {
      print(email);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
        }),
      );
      switch (response.statusCode) {
        case 200:
          print(response.statusCode);
          response.body == true
              ? showAboutDialog(
                  context: context,
                  children: [
                    const Text('사용가능'),
                  ],
                )
              : showAboutDialog(
                  context: context, children: [const Text('중복된')]);

          break;

        case 500:
          print('${response.body} + 상태 코드 : ${response.statusCode}흐규흐규');
          break;
        default:
          print('알 수 없는 오류가 발생했습니다. 상태 코드: ${response.statusCode}');
          // 기타 상태 코드에 대한 처리
          break;
      }
    } catch (e) {
      print('네트워크 오류 발생 $e');
    }
  }

  // 닉네임 중복 확인
  Future<void> nicknameCheck() async {
    Uri url = Uri.parse('http://43.201.84.66:8080/api/check/nickname');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nickname': nickname,
        }),
      );
      switch (response.statusCode) {
        case 200:
          print('저는 ㅎ ㅔ더에오 : ${response.body}');
          break;

        case 500:
          print('${response.body} + 상태 코드 : ${response.statusCode}흐규흐규');
          break;
        default:
          print('알 수 없는 오류가 발생했습니다. 상태 코드: ${response.statusCode}');
          // 기타 상태 코드에 대한 처리
          break;
      }
    } catch (e) {
      print('네트워크 오류 발생 $e');
    }
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
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: HexColor('#E3E3E3'),
        shape: Border(bottom: BorderSide(color: HexColor('#E3E3E3'))),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '회원가입',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: txtColor_1,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              key: formKey_email,
                              hintText: '이메일',
                              obscureText: false,
                              sufficIcon: DuplicationCheckButton(onTap: () {
                                formKey_email.currentState?.validate() ?? false
                                    ? emailCheck()
                                    : emailCheck();
                              }),
                              onChanged: (newValue) {
                                setState(() {
                                  email = newValue;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '이메일을 입력하세요';
                                } else {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = RegExp(pattern);
                                  if (!regExp.hasMatch(value)) {
                                    return '잘못된 이메일 형식입니다.';
                                  } else {
                                    return null; //null을 반환하면 정상
                                  }
                                }
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
                              key: formKey_nickname,
                              hintText: '닉네임',
                              obscureText: false,
                              sufficIcon:
                                  DuplicationCheckButton(onTap: emailCheck),
                              onChanged: (newValue) {
                                setState(() {
                                  nickname = newValue;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) return '닉네임을 입력하세요';
                                return null;
                              },
                              onSaved: (val) {
                                setState(() {
                                  nickname = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            CustomTextFormField(
                              key: formKey_password,
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
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
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
                            '회원가입',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          print('폼 미');
                          formKey.currentState!.save();
                          print('$email\n$nickname\n$password');
                          signin();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
