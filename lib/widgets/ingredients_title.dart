import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';

class IngredientsTile extends StatefulWidget {
  final String title;
  final List<String> imagePaths; // 리스트의 이름이 바뀌어야 할 수도 있음, 예를 들어 textItems

  const IngredientsTile(
      {super.key, required this.title, required this.imagePaths});

  @override
  State<IngredientsTile> createState() => _IngredientsTileState();
}

class _IngredientsTileState extends State<IngredientsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(widget.title),
          initiallyExpanded: false,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0, // 아이템 간의 가로 간격
                runSpacing: 8.0, // 아이템 간의 세로 간격
                children: widget.imagePaths.map((path) {
                  String textName = path;
                  return GestureDetector(
                    onTap: () {
                      // 텍스트 클릭 시 텍스트 이름과 경로 출력
                      print('Text Name: $textName');
                      print('Text Path: $path');
                      // 여기서 다른 동작을 추가할 수 있습니다.
                      // 누르면 하단 카드 소환!!
                      showModal(context);
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
                          textName, // 텍스트 표시
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
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

  void showModal(BuildContext context) {
    String name = '머시기';
    String category = '저시기';
    int cnt = 1;

    DateTime purchaseDate = DateTime.now(); // 구매 날짜
    DateTime expirationDate = DateTime.now(); // 만료 날짜
    bool isRefrigerated = false;
    bool isFrozen = false;

    String dDay(DateTime purchaseDate, DateTime expirationDate) {
      var difference = purchaseDate.difference(expirationDate).inDays;
      String dDay;

      if (difference > 0) {
        dDay = "D-$difference";
      } else if (difference < 0) {
        dDay = "D+$difference";
      } else {
        dDay = "D-day";
      }
      print(dDay);
      return dDay;
    }

    showModalBottomSheet(
      //bottom modal sheet 사용
      backgroundColor: background,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            height: MediaQuery.sizeOf(context).height * 0.51, // 비율 설정 (반절 정도)
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.only(
                // 모달창 상단 둥글게
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
                    // 재료 카드 & 재료 이름, 유통 기한 표시
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
                                      '$name / $category',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        height: 2,
                                      ),
                                    ),
                                    Text(
                                      '$cnt마리',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '구매 날짜',
                        style: TextStyle(
                          color: HexColor('#313131'),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: HexColor('#313131'),
                                size: 13,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('dd.MM.yyyy').format(purchaseDate),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: purchaseDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              purchaseDate = selectedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '유통기한',
                        style: TextStyle(
                          color: HexColor('#313131'),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: HexColor('#313131'),
                                size: 13,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('dd.MM.yyyy').format(expirationDate),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: expirationDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              expirationDate = selectedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 30.0, left: 30.0, top: 20, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '냉장 보관',
                        style: TextStyle(
                          color: HexColor('#313131'),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch.adaptive(
                        value: isRefrigerated,
                        activeColor: primary,
                        onChanged: (bool value) {
                          setModalState(() {
                            isRefrigerated = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '냉동 보관',
                        style: TextStyle(
                          color: HexColor('#313131'),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CupertinoSwitch(
                        value: isFrozen,
                        activeColor: primary,
                        onChanged: (bool value) {
                          setModalState(() {
                            isFrozen = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
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
                              '재료 삭제',
                              style: TextStyle(
                                color: HexColor('#4C4C4C'),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: primary,
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
                              '확인',
                              style: TextStyle(
                                color: HexColor('#FFFFFF'),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
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
