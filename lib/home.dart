import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/add_ingredients.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colos.dart';
import 'package:refrigerator_frontend/search_ingredients.dart';

import 'bookmark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          // 각 탭별 페이지
          children: [
            Center(
              child: Home(),
            ),
            Center(
              child: SearchIngredientsScreen(),
            ),
            const Center(
              child: BookMarkScreen(),
            ),
          ],
        ),
        bottomNavigationBar: PreferredSize(
          //하단 탭바 (바텀 네비게이션 바 역할)
          preferredSize: const Size.fromHeight(85),
          child: Container(
            height: 85,
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: background,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 15.0,
                  spreadRadius: 5.0,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: TabBar(
              tabs: const [
                Tab(
                  icon: Icon(Icons.home_outlined),
                  child: SizedBox(height: 30),
                ),
                Tab(
                  icon: Icon(Icons.search),
                  child: SizedBox(height: 30),
                ),
                Tab(
                  icon: Icon(Icons.star_border),
                  child: SizedBox(height: 30),
                ),
              ],
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: selectedIconColor,
              unselectedLabelColor: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  DateTime today = DateTime.now();
  var weekdays = {
    // 요일 map으로 저장
    0: '월요일',
    1: '화요일',
    2: '수요일',
    3: '목요일',
    4: '금요일',
    5: '토요일',
    6: '일요일',
  };
  int ingredient_cnt = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.track_changes_outlined,
            size: 25,
            color: iconColor,
          ),
          onPressed: () {},
        ),
        title: Image.asset(
          'assets/images/logo.png',
          width: 137,
          height: 137,
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
                    builder: (BuildContext context) => AddIngredientsScreen()),
              );
            },
          ),
        ],
        backgroundColor: background,
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '재희의 냉장고',
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
            Expanded(
              child: GridView.builder(
                //재료 아이템 표시
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: ingredient_cnt,
                itemBuilder: (context, index) {
                  return const _buildIngredientCard(); // 카드 빌드해서 리턴
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildIngredientCard extends StatefulWidget {
  const _buildIngredientCard({
    super.key,
  });

  @override
  State<_buildIngredientCard> createState() => _buildIngredientCardState();
}

class _buildIngredientCardState extends State<_buildIngredientCard> {
  DateTime purchase_date = DateTime.now();
  DateTime expiration_date = DateTime.now();
  bool toggled_refrigeration = false;
  bool toggled_freezing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context); // 재료 누르면 하단에서 모달 창 나오게 하는 함수 호출
      },
      child: IngredientCard(
        //라벨 있는 카드 생성
        color: const Color.fromARGB(255, 242, 242, 242),
        name: '당근',
        path: 'carrot',
      ),
    );
  }

  // 하단 모달 창 생성 함수
  void _showModal(BuildContext context) {
    String name = '머시기';
    String category = '저시기';
    int cnt = 1;

    showModalBottomSheet(
      //bottom modal sheet 사용
      backgroundColor: background,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
                                'D-1',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
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
                              DateFormat('dd.MM.yyyy').format(purchase_date),
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
                          initialDate: purchase_date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            purchase_date = selectedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
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
                              DateFormat('dd.MM.yyyy').format(expiration_date),
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
                          initialDate: expiration_date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            expiration_date = selectedDate;
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
                    CupertinoSwitch(
                      value: toggled_refrigeration,
                      activeColor: primary,
                      onChanged: (bool value) {
                        setState(() {
                          toggled_refrigeration = value;
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
                      value: toggled_freezing,
                      activeColor: primary,
                      onChanged: (bool value) {
                        setState(() {
                          toggled_freezing = value;
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
        );
      },
    );
  }
}

class IngredientModal extends StatefulWidget {
  const IngredientModal({super.key});

  @override
  State<IngredientModal> createState() => _IngredientModalState();
}

class _IngredientModalState extends State<IngredientModal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
