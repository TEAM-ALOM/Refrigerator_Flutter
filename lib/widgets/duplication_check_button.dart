import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/sign_in_screen.dart';

class DuplicationCheckButton extends StatelessWidget {
  // 중복 체크 버튼
  const DuplicationCheckButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hihi');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            color: HexColor('#F2F2F2'),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '중복확인',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: txtColor_2,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
