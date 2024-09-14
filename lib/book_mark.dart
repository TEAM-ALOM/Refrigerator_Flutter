import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

List<String> items = List.generate(6, (index) => 'Item ${index + 1}');
List<bool> isBookMarked = List.generate(6, (index) => true); // 삭제 상태 관리 리스트


final List<String> imagePaths = [
  'assets/images/food/food.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/food.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/food.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/food.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/food.png',
  'assets/images/food/돼지고기 김치볶음.png',
  'assets/images/food/food.png',
];


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  // 데이터 리스트

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
              child: GestureDetector( // 클릭 이벤트 추가
                onTap: () {
                  print('${items[index]} 클릭됨');
                  print(isBookMarked);
                },
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          imagePaths[index], // 로컬 이미지 불러오기
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '돼지고기 김치볶음 ${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '조리시간: ${index + 1}분',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    print('삭제된 아이템 인덱스: $index');
                                    isBookMarked[index] = false; // 상태 리스트를 true로
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
