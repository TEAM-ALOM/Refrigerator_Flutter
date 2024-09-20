import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/user_auth.dart';
import 'materials_in_refri.dart';
import 'package:http/http.dart' as http;

class BookMarkItem extends StatefulWidget {
  //즐겨찾기된 레시피 위젯
  final String imagePath; // 레시피 아이디
  final String foodName; // 음식 이름
  final String cookingTime; // 조리시간
  final bool isMarked; // 즐겨찾기 상태
  final VoidCallback onDelete; // 삭제버튼 함수
  final Function(String) onViewRecipe; // 레시피 보기 함수
  final List<String> materials; // 재료 리스트

  const BookMarkItem({
    super.key,
    required this.imagePath,
    required this.foodName,
    required this.cookingTime,
    required this.isMarked,
    required this.onDelete,
    required this.onViewRecipe,
    required this.materials,
  });

  @override
  _BookMarkItemState createState() => _BookMarkItemState();
}


Future<void> fetchRecipe(String id) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/recipe/detail/${id}');
  String? myToken = await getAccessToken();

  if (myToken == null) {
    print('Failed to get token');
    return;
  }

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
      },
    );


    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      print(data);

    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}



class _BookMarkItemState extends State<BookMarkItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 클릭 시 회색으로 설정
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTap: () {
        //search_screen.dart에 있음.
        widget.onViewRecipe(widget.foodName); // 레시피 보기 함수 호출

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          color: _isTapped ? Colors.grey[300] : Colors.transparent,
          child: SizedBox(
            height: 160,
            child: Column(
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            widget.imagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.foodName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.star_rounded,
                          size: 30,
                          color: Color(0xFF0754DD),
                        ),
                        onPressed: widget.onDelete,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.materials
                        .map((material) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: materialsInRefri(material),
                            ))
                        .toList(),
                  ),
                ),
                const Divider(color: Color(0xFFF1F1F1), thickness: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
