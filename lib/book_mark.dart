import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colos.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        centerTitle: true, // 텍스트를 가운데 정렬
        title: Text('즐겨찾기1'),
        backgroundColor: background,
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView.builder(
          itemCount: 3, // 박스 3개 생성
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Card(
                // shape: Rectangle(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/images/food/food.png', // 이미지 경로 수정
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    'Bookmark Item ${index + 1}', // 글씨 표시
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'This is the subtitle for item ${index + 1}.', // 부가 설명
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    // 각 박스 클릭 시 동작
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
