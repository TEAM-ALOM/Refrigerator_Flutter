import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:refrigerator_frontend/screens/bookmark_screen.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/roulette_screen.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // 홈 화면

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          // 각 탭별 페이지
          children: [
            Center(
              child: Home(),
            ),
            Center(
              child: SearchScreen(),
            ),
            Center(
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  List<String> ingredients = ['당근', '우유', '치즈', '닭', '시금치', '푸딩'];

  int ingredientCnt = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNickname();
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
              // Expanded(
              //   child: GridView.builder(
              //     //재료 아이템 표시
              //     padding: EdgeInsets.zero,
              //     scrollDirection: Axis.vertical,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4,
              //       mainAxisSpacing: 30,
              //       crossAxisSpacing: 20,
              //       childAspectRatio: 1,
              //     ),
              //     itemCount: ingredient_cnt,
              //     itemBuilder: (context, index) {
              //       return const _buildIngredientCard(); // 카드 빌드해서 리턴
              //     },
              //   ),
              // ),
              Wrap(
                spacing: 8,
                children: List<Widget>.generate(ingredients.length, (index) {
                  return _buildIngredientCard(i: index);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildIngredientCard extends StatefulWidget {
  _buildIngredientCard({
    super.key,
    required this.i,
  });
  int i;
  @override
  State<_buildIngredientCard> createState() => _buildIngredientCardState();
}

class _buildIngredientCardState extends State<_buildIngredientCard> {
  DateTime purchaseDate = DateTime.now();
  DateTime expirationDate = DateTime.now();
  bool toggledRefrigeration = false;
  bool toggledFreezing = false;

  String dDay0(DateTime purchaseDate, DateTime expirationDate) {
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

  @override
  Widget build(BuildContext context) {
    int dDay = purchaseDate.difference(expirationDate).inDays;
    return GestureDetector(
      onTap: () {
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
          width: widget.i * 50 + 40,
          child: const Center(
            child: Text(
              '이름',
            ),
          ),
        ),
      ),
    );
  }

  // 하단 모달 창 생성 함수
  void showModal(BuildContext context) {
    String name = '머시기';
    String category = '저시기';
    int cnt = 1;

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
                                  dDay0(purchaseDate, expirationDate),
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
                        value: toggledRefrigeration,
                        activeColor: primary,
                        onChanged: (bool value) {
                          setModalState(() {
                            toggledRefrigeration = value;
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
                        value: toggledFreezing,
                        activeColor: primary,
                        onChanged: (bool value) {
                          setModalState(() {
                            toggledFreezing = value;
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
