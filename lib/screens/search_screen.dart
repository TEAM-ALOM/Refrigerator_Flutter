import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';
import 'package:refrigerator_frontend/screens/recipe_screen.dart';
import 'package:refrigerator_frontend/widgets/bookmark_item.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late TextEditingController textController;
  String textContent = "";

  int? _value;
  List<String> categories = [
    '한식',
    '중국',
    '일본',
    '서양',
    '퓨전',
    '이탈리아',
    '동남아시아',
  ];

  List<String> items = List.generate(6, (index) => '김치찌개 $index'); // 음식 이름명
  List<bool> isBookMarked =
      List.generate(6, (index) => true); // 즐겨찾기 삭제 상태 관리 리스트
  //List recipes = [];
  List<Map<String, dynamic>> recipes = [];

  final List<String> imagePaths = [
    // 음식 이미지 경로 배열
    'assets/images/food/food.png',
    'assets/images/food/food1.png',
    'assets/images/food/김치볶음밥.png',
    'assets/images/food/돼지고기 김치볶음.png',
    'assets/images/food/미역국.png',
    'assets/images/food/순두부찌개.png',
    'assets/images/food/돼지고기 김치볶음.png',
    'assets/images/food/돼지고기 김치볶음.png',
    'assets/images/food/돼지고기 김치볶음.png',
    'assets/images/food/돼지고기 김치볶음.png',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    textController = TextEditingController();
    getAllRecipe(0);
    //getAllRecipe(1);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  // 레시피를 보는 함수
  void viewRecipe(String foodName) {
    print('$foodName의 레시피를 확인합니다.');
    print(isBookMarked);
    // 다른 화면으로 이동하거나 레시피 정보를 출력하는 로직 추가 가능
    // Navigator.push(context, ...); 등으로 상세 레시피 페이지로 이동 가능
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const RecipeScreen(),
      ),
    );
  }

  Future<void> getAllRecipe(int page) async {
    final Uri url = Uri.parse('http://43.201.84.66:8080/api/recipe/all/$page');
    String? myToken = await getAccessToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $myToken',
        },
      );

      if (response.statusCode == 200) {
        // 서버에서 받아온 JSON 데이터 파싱
        // 서버에서 받아온 바이트 데이터를 UTF-8로 변환
        final String decodedBody = utf8.decode(response.bodyBytes);

        // JSON 데이터 파싱
        final List<dynamic> data = json.decode(decodedBody);
        print(data);
        setState(() {
          // 데이터 처리
          recipes = data.map((item) {
            // 각 필드의 null 값 체크 및 기본값 설정
            return {
              'id': item['id'] ?? 0,
              'title': item['title'] ?? '',
              'category': item['category'] ?? '',
              'thumbnail': item['thumbnail'] ?? '',
              'ingredients': (item['ingredients'] as List<dynamic>? ?? [])
                  .map((ingredient) => {
                        'id': ingredient['id'] ?? 0,
                        'name': ingredient['name'] ?? '',
                        'category': ingredient['category'] ?? '',
                        'quantity': ingredient['quantity'] ?? 0,
                        'expirationDate': ingredient['expirationDate'] ?? '',
                        'purchaseDate': ingredient['purchaseDate'] ?? '',
                        'isContained': ingredient['isContained'] ?? false,
                      })
                  .toList(),
            };
          }).toList();
          //recipes[page] = recipe;
          print("레시피에오 : ${recipes[0]}");
        });

        // 데이터 확인
        print(recipes);
      } else {
        // 오류 처리
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 18.0,
            left: 18.0,
          ),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.search,
              ),
              prefix: _isFocused ? null : null,
              hintText: '레시피 검색하기',
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.6),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: primary,
                ),
              ),
            ),
            cursorColor: primary,
            autofocus: false,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // 추천 레시피와 카테고리 부분을 SliverToBoxAdapter로 감싸서 Sliver로 변환
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 25.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '추천 레시피',
                    style: TextStyle(
                      color: txtColor_1,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 217,
                      width: 351,
                      child: Image.asset('assets/images/고등어무조림.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '카테고리',
                      style: TextStyle(
                        color: txtColor_1,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    children: List<Widget>.generate(categories.length, (index) {
                      return ChoiceChip(
                        label: Text(categories[index]),
                        selected: _value == index,
                        selectedColor: Colors.blue[100],
                        backgroundColor: background,
                        showCheckmark: false,
                        side: BorderSide(
                          color: HexColor('D9D9D9'),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
          // ListView.builder 대신 SliverList 사용
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BookMarkItem(
                    materials: const [],
                    imagePath: imagePaths[index],
                    foodName: items[index],
                    cookingTime: '${index + 10}분',
                    isMarked: isBookMarked[index],
                    onDelete: () {
                      setState(() {
                        print('삭제된 아이템 인덱스: $index');
                        isBookMarked[index] = false;
                        items.removeAt(index); // 화면에서 삭제
                      });
                    },
                    onViewRecipe: viewRecipe, // 레시피 보기 함수 전달
                  ),
                );
              },
              childCount: 6, // 아이템 개수
            ),
          ),
        ],
      ),
    );
  }
}
