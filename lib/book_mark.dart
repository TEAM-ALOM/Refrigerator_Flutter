import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/widgets/bookmark_item.dart';
import 'colors.dart';

List<String> items = List.generate(6, (index) => '김치찌개 ${index}'); // 음식 이름명
List<bool> isBookMarked = List.generate(6, (index) => true); // 즐겨찾기 삭제 상태 관리 리스트

final List<String> imagePaths = [ // 음식 이미지 경로 배열
  'assets/images/food/food.png',
  'assets/images/food/food1.png',
  'assets/images/food/김치볶음밥.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/미역국.png',
  'assets/images/food/순두부찌개.png',
];

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('즐겨찾기'),
        backgroundColor: background,
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BookMarkItem(
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
        ),
      ),
    );
  }
}


