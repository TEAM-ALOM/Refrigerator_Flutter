import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colos.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  // 데이터 리스트
  List<String> items = List.generate(3, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        centerTitle: true, // 텍스트를 가운데 정렬
        title: Text('즐겨찾기'),
        backgroundColor: background,
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length, // 리스트 길이에 따라 항목 개수 설정
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 120, // 박스의 높이 설정
                child: Row(
                  children: [
                    // 왼쪽 이미지
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/images/food/돼지고기 김치볶음.png', // 이미지 경로 수정
                        fit: BoxFit.contain,
                      ),
                    ),
                    // 오른쪽 텍스트와 삭제 버튼
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
                                    '돼지고기 김치볶음 ${index + 1}', // 글씨 표시
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '조리시간: ${index + 1}분', // 부가 설명
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 삭제 버튼
                            IconButton(
                              icon: Icon(
                                Icons.delete, // 기본 삭제 아이콘
                                size: 24,
                                color: Colors.grey, // 삭제 버튼 색상
                              ),
                              onPressed: () {
                                setState(() {
                                  // 항목 삭제
                                  items.removeAt(index);
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
            );
          },
        ),
      ),
    );
  }
}
