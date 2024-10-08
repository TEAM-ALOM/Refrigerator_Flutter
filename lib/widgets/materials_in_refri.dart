
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 가지고 있는 재료 위젯
// 레시피 페이지에서 재료 위젯으로 재탕 가능!!

Widget materialsInRefri(String text) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFCED9EC),
      shape: BoxShape.rectangle, // 네모박스
      borderRadius: BorderRadius.circular(15), // 테두리 둥글게
    ),
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}