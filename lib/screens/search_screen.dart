import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/widgets/bookmark_item.dart';

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
  List<String> categories = ['한식', '양식', '베트남 음식', '메인 요리'];

  List<String> items = List.generate(6, (index) => '김치찌개 $index'); // 음식 이름명
  List<bool> isBookMarked =
      List.generate(6, (index) => true); // 즐겨찾기 삭제 상태 관리 리스트

  final List<String> imagePaths = [
    // 음식 이미지 경로 배열
    'assets/images/food/food.png',
    'assets/images/food/food1.png',
    'assets/images/food/김치볶음밥.png',
    'assets/images/food/돼지고기 김치볶음.png',
    'assets/images/food/미역국.png',
    'assets/images/food/순두부찌개.png',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    textController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 25.0),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.search,
              ),
              prefix: _isFocused ? null : null,
              hintStyle: TextStyle(
                color: primary,
                fontSize: 20,
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: HexColor('#F1F1F1'),
                        ),
                      ),
                    ),
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
