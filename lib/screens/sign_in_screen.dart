import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/widgets/custom_textformfield.dart';
import 'package:refrigerator_frontend/widgets/duplication_check_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

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
                              hintText: '이메일',
                              sufficIcon: const DuplicationCheckButton(),
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
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            CustomTextFormField(
                              hintText: '닉네임',
                              sufficIcon: const DuplicationCheckButton(),
                              validator: (value) {
                                if (value!.isEmpty) return '닉네임을 입력하세요';
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            CustomTextFormField(
                              hintText: '비밀번호',
                              sufficIcon: null,
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
