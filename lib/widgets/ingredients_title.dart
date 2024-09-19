import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/models/get_ingredient_id.dart';
import 'package:refrigerator_frontend/screens/main_tab_bar.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:http/http.dart' as http;
import '../models/send_ingredients_to_server.dart';
import '../models/user_auth.dart';

class IngredientsTile extends StatefulWidget {
  final String title;
  final Map<String, String> ingredientsMap;

  const IngredientsTile(
      {super.key, required this.title, required this.ingredientsMap});

  @override
  State<IngredientsTile> createState() => _IngredientsTileState();
}

class _IngredientsTileState extends State<IngredientsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(
            widget.title,
            style: const TextStyle(fontFamily: "CookieRun"),
          ),
          initiallyExpanded: false,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0, // 아이템 간의 가로 간격
                runSpacing: 8.0, // 아이템 간의 세로 간격
                children: widget.ingredientsMap.entries.map((entry) {
                  String ingredient = entry.key;
                  String category = entry.value;
                  return GestureDetector(
                    onTap: () {
                      showModal(context, ingredient, category);
                    },
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 120.0, // 텍스트 길이에 따라 조정할 수 있는 최대 너비
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          ingredient, // 텍스트 표시
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontFamily: "CookieRun",
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true, // 텍스트 자동 줄 바꿈
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const Divider(height: 1.0, color: Colors.grey), // 구분선 추가
      ],
    );
  }

  void showModal(BuildContext context, String ingredient, String category) {
    int cnt = 1;

    DateTime purchaseDate = DateTime.now();
    DateTime expirationDate = DateTime.now();
    bool isRefrigerated = false;
    bool isFrozen = false;

    // D-Day 계산 함수
    String dDay(DateTime purchaseDate, DateTime expirationDate) {
      final int difference = expirationDate.difference(purchaseDate).inDays;
      if (difference > 0) return "D-$difference";
      if (difference < 0) return "D+${difference.abs()}";
      return "D-day";
    }

    // 날짜 선택 Row 빌드 함수
    Widget buildDatePickerRow(String label, DateTime date, VoidCallback onTap) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: HexColor('#313131'),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      color: HexColor('#313131'), size: 13),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd.MM.yyyy').format(date),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 스위치 Row 빌드 함수
    Widget buildSwitchRow(
        String label, bool value, ValueChanged<bool> onChanged) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: HexColor('#313131'),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch.adaptive(
              value: value,
              activeColor: primary,
              onChanged: onChanged,
            ),
          ],
        ),
      );
    }

    // 버튼 빌드 함수
    Widget buildButton(String text, Color textColor, Color backgroundColor,
        VoidCallback onPressed) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: HexColor('#D9D9D9')),
          ),
        ),
        child: SizedBox(
          width: 140,
          height: 40,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
      backgroundColor: background,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            height: MediaQuery.sizeOf(context).height * 0.51,
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: 155,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: HexColor('#DEDEDE'),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IngredientCardWithoutLabel(
                        color: const Color.fromARGB(255, 11, 64, 161)
                            .withOpacity(0.2),
                        path: 'carrot',
                      ),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: HexColor('#F2F2F2'),
                        child: SizedBox(
                          width: 266,
                          height: 72,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 19.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$ingredient / $category',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        height: 2,
                                      ),
                                    ),
                                    Text(
                                      '$cnt개',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor('#676767'),
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  dDay(purchaseDate, expirationDate),
                                  style: TextStyle(
                                    color: HexColor('#DF0000'),
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                buildDatePickerRow('구매 날짜', purchaseDate, () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: purchaseDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setModalState(() {
                      purchaseDate = selectedDate;
                    });
                  }
                }),
                buildDatePickerRow('유통기한', expirationDate, () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: expirationDate,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                  );
                  if (selectedDate != null) {
                    setModalState(() {
                      expirationDate = selectedDate;
                    });
                  }
                }),
                buildSwitchRow('냉장 보관', isRefrigerated, (bool value) {
                  setModalState(() {
                    isRefrigerated = value;
                  });
                }),
                buildSwitchRow('냉동 보관', isFrozen, (bool value) {
                  setModalState(() {
                    isFrozen = value;
                  });
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('뒤로 가기', HexColor('#4C4C4C'), Colors.white,
                          () {
                        Navigator.pop(context);
                      }),
                      buildButton('확인', HexColor('#FFFFFF'), primary, () async {
                        // 비동기 작업 수행
                        String id = await getIngredientId(ingredient);
                        await sendIngredientToServer(
                          ingredientId: int.parse(id),
                          category: category,
                          quantity: 1,
                          purchaseDate: purchaseDate,
                          expirationDate: expirationDate,
                          isFrozen: isFrozen,
                          isRefrigerated: isRefrigerated,
                        );

                        print(category);
                        print(ingredient);

                        // SnackBar 생성
                        final snackBar = SnackBar(
                          content: Text(
                            '$ingredient(이)가 냉장고에 추가되었습니다.',
                            style: const TextStyle(fontFamily: "CookieRun"),
                            textAlign: TextAlign.center,
                          ),
                          duration: const Duration(seconds: 3), // 메시지 표시 시간
                        );

                        // 모달창 내부에서 ScaffoldMessenger를 사용하여 SnackBar를 표시합니다.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // 모달창 닫기
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
