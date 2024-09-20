import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:refrigerator_frontend/screens/bookmark_screen.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/roulette_screen.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();

  var weekdays = {
    // 요일 map으로 저장
    1: '월요일',
    2: '화요일',
    3: '수요일',
    4: '목요일',
    5: '금요일',
    6: '토요일',
    7: '일요일',
  };

  List<Map<String, dynamic>> ingredients = [];

  int ingredientCnt = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNickname();
    getAllIngredients();
  }

  String nickname = '';
  final storage = const FlutterSecureStorage();

  // 저장된 닉네임 불러오기
  Future<void> _loadNickname() async {
    String? savedNickname = await storage.read(key: 'nickname');
    setState(() {
      nickname = savedNickname ?? '';
    });
  }

  // 사용자가 추가한 재료 전체 조회
  Future<void> getAllIngredients() async {
    final Uri url =
        Uri.parse('http://43.201.84.66:8080/api/refrigerator/userIngredient');
    String? myToken = await getAccessToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $myToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        print('저는 데이터 에요 : #$data');

        // data를 Map 형태로 변환 후 리스트로 저장
        setState(() {
          ingredients = List<Map<String, dynamic>>.from(data.map((item) {
            return {
              'ingredientId': item['ingredientId'],
              'ingredientName': item['ingredientName'],
            };
          }));
          //print(ingredients);
        });
      } else {
        // 오류 처리
        throw Exception('Failed to load ingredients');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            //돌림판 아이콘
            Icons.track_changes_outlined,
            size: 25,
            color: iconColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const RouletteScreen()),
            );
          },
        ),
        title: Text(
          '냉장고의 꿈',
          style: TextStyle(
            fontFamily: 'CookieRun',
            color: primary,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: iconColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const AddIngredientsScreen()),
              );
            },
          ),
        ],
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: HexColor('#E3E3E3'),
        shape: Border(bottom: BorderSide(color: HexColor('#E3E3E3'))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$nickname의 냉장고',
                style: TextStyle(
                  color: HexColor('#303030'),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  '${today.month}월 ${today.day}일 ${weekdays[today.weekday]}', // 오늘 날짜 표시
                  style: TextStyle(
                    color: HexColor('#303030'),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                spacing: 8,
                children: List<Widget>.generate(ingredients.length, (index) {
                  return BuildIngredientCard(
                    id: ingredients[index]['ingredientId'],
                    name: ingredients[index]['ingredientName'],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildIngredientCard extends StatefulWidget {
  BuildIngredientCard({
    super.key,
    required this.id,
    required this.name,
  });
  int id;
  String name;

  @override
  State<BuildIngredientCard> createState() => _BuildIngredientCardState();
}

class _BuildIngredientCardState extends State<BuildIngredientCard> {
  DateTime purchaseDate = DateTime.now();
  DateTime expirationDate = DateTime.now();

  Map<String, dynamic> detail = {};

  var updatedData = {
    "ingredientId": 1, // 변경할 ingredientId
    "category": "updated category",
    "quantity": 5,
    "purchaseDate": "2024-09-20",
    "expiredDate": "2024-09-30",
    "isFrozen": false,
    "isRefrigerated": true,
  };

  // 날짜 문자열을 DateTime 객체로 변환
  DateTime parseDate(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  // d-day 계산 함수
  String dDay(DateTime purchaseDate, DateTime expirationDate) {
    var difference = purchaseDate.difference(expirationDate).inDays;
    String dDay;

    if (difference > 0) {
      dDay = "D-$difference";
    } else if (difference < 0) {
      dDay = "D+${difference.abs()}";
    } else {
      dDay = "D-day";
    }
    print(dDay);
    return dDay;
  }

  // d-day 계산 함수
  int dDaytoInt(DateTime purchaseDate, DateTime expirationDate) {
    var difference = purchaseDate.difference(expirationDate).inDays;

    print(difference);
    return difference;
  }

  // 사용자가 추가한 재료 전체 조회
  Future<void> getDetailUserIngredient(int ingredientId) async {
    final Uri url = Uri.parse(
        'http://43.201.84.66:8080/api/refrigerator/userIngredient/${ingredientId.toString()}');

    String? myToken = await getAccessToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $myToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(utf8.decode(response.bodyBytes));

        // 날짜 문자열을 DateTime 객체로 변환
        DateTime parseDate(String dateString) {
          return DateFormat('yyyy-MM-dd').parse(dateString);
        }

        // data를 Map 형태로 변환 후 리스트로 저장
        setState(() {
          detail = {
            'name': data['name'],
            'category': data['category'],
            'quantity': data['quantity'],
            'purchaseDate': parseDate(data['purchaseDate']),
            'expiredDate': parseDate(data['expiredDate']),
            'isFrozen': data['isFrozen'],
            'isRefrigerated': data['isRefrigerated'],
          };
        });
        print('저는 detail 이에오 : $detail');
      } else {
        // 오류 처리
        throw Exception('Failed to load ingredients ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // 사용자 재료 정보 업데이트
  Future<void> patchIngredient(
      int ingredientId, Map<String, dynamic> updatedData) async {
    final Uri url = Uri.parse(
        'http://43.201.84.66:8080/api/refrigerator/userIngredient/${ingredientId.toString()}');

    String? myToken = await getAccessToken();
    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $myToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedData), // 업데이트할 데이터
      );

      if (response.statusCode == 200) {
        print('성공적으로 업데이트되었습니다: ${response.body}');
      } else {
        print('업데이트 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int dDay = purchaseDate.difference(expirationDate).inDays;
    dDay = dDaytoInt(purchaseDate, expirationDate);

    return GestureDetector(
      onTap: () async {
        print(widget.id);
        await getDetailUserIngredient(widget.id);
        showModal(context); // 재료 누르면 하단에서 모달 창 나오게 하는 함수 호출
      },
      child: Card(
        elevation: 0,
        color: dDay > 3
            ? background // 3 일보다 많이 남았으면 회색
            : dDay == 3
                ? HexColor('#FF0000').withOpacity(0.1) // 3일
                : dDay == 2
                    ? HexColor('#FF0000').withOpacity(0.25) // 2일
                    : dDay < 0
                        ? HexColor('#FF0000').withOpacity(0.8) // 유통기한 지남
                        : HexColor('#FF0000').withOpacity(0.5), // D-day
        child: SizedBox(
          height: 40,
          width: widget.name.length * 20,
          child: Center(
            child: Text(
              widget.name,
            ),
          ),
        ),
      ),
    );
  }

  // 하단 모달 창 생성 함수
  void showModal(BuildContext context) {
    DateTime purchaseDate = detail['purchaseDate'];
    DateTime expirationDate = detail['expiredDate'];
    bool isRefrigerated = detail['isRefrigerated'];
    bool isFrozen = detail['isFrozen'];

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
                                      '${detail['name']} / ${detail['category']}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        height: 2,
                                      ),
                                    ),
                                    Text(
                                      '${detail['quantity']}개',
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
                            lastDate: DateTime(2025),
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
                        onPressed: () {
                          setState(() {
                            updatedData = {
                              "ingredientId": widget.id, // 변경할 ingredientId
                              "category": "${detail['category']}",
                              "quantity": 1,
                              "purchaseDate":
                                  DateFormat('yyyy-MM-dd').format(purchaseDate),
                              "expiredDate": DateFormat('yyyy-MM-dd')
                                  .format(expirationDate),
                              "isFrozen": isFrozen,
                              "isRefrigerated": isRefrigerated,
                            };
                            patchIngredient(widget.id, updatedData);
                            Navigator.pop(context);
                          });
                        },
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
