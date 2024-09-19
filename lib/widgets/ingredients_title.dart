import 'package:flutter/material.dart';

class IngredientsTile extends StatelessWidget {
  final String title;
  final List<String> imagePaths; // 리스트의 이름이 바뀌어야 할 수도 있음, 예를 들어 textItems

  IngredientsTile({required this.title, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(title),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0, // 아이템 간의 가로 간격
                runSpacing: 8.0, // 아이템 간의 세로 간격
                children: imagePaths.map((path) {
                  String textName = path;
                  return GestureDetector(
                    onTap: () {
                      // 텍스트 클릭 시 텍스트 이름과 경로 출력
                      print('Text Name: $textName');
                      print('Text Path: $path');
                      // 여기서 다른 동작을 추가할 수 있습니다.
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 120.0, // 텍스트 길이에 따라 조정할 수 있는 최대 너비
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          textName, // 텍스트 표시
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true, // 텍스트 자동 줄 바꿈
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          initiallyExpanded: false,
        ),
        Divider(height: 1.0, color: Colors.grey), // 구분선 추가
      ],
    );
  }
}