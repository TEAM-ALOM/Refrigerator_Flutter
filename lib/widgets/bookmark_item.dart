import 'package:flutter/material.dart';

class BookMarkItem extends StatefulWidget {
  final String imagePath; // 음식 이미지 경로
  final String foodName; // 음식 이름
  final String cookingTime; // 조리시간
  final bool isMarked; // 즐겨찾기 상태
  final VoidCallback onDelete; // 삭제버튼 함수
  final Function(String) onViewRecipe; // 레시피 보기 함수

  const BookMarkItem({
    Key? key,
    required this.imagePath,
    required this.foodName,
    required this.cookingTime,
    required this.isMarked,
    required this.onDelete,
    required this.onViewRecipe,
  }) : super(key: key);

  @override
  _BookMarkItemState createState() => _BookMarkItemState();
}

class _BookMarkItemState extends State<BookMarkItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //클릭시 회색으로 설정
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
        widget.onViewRecipe(widget.foodName); // 레시피 보기 함수 호출

      },
      child: Container(
        color: _isTapped ? Colors.grey[300] : Colors.transparent,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  widget.imagePath,
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
                              widget.foodName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '조리시간: ${widget.cookingTime}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.star,
                          size: 24,
                          color: Color(0xFF0754DD),
                        ),
                        onPressed: widget.onDelete,
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
  }
}