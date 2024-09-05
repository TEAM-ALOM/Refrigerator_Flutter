import 'package:flutter/material.dart';

class IngredientsTile extends StatelessWidget {
  final String title;
  final List<String> imagePaths;

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
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 한 줄에 4개의 아이템
                  crossAxisSpacing: 8.0, // 가로 간격
                  mainAxisSpacing: 8.0, // 세로 간격
                  childAspectRatio: 1.0, // 정사각형 비율
                ),
                itemCount: imagePaths.length, // 이미지 개수
                itemBuilder: (context, index) {
                  // 이미지 파일 이름 추출 및 확장자 제거
                  String fileName = imagePaths[index]
                      .split('/')
                      .last
                      .split('.')
                      .first;

                  return GestureDetector(
                    onTap: () {
                      // 이미지 클릭 시 이미지 이름과 경로 출력
                      print('Image Name: $fileName');
                      print('Image Path: ${imagePaths[index]}');
                      // 여기서 다른 동작을 추가할 수 있습니다.
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                imagePaths[index], // 로컬 이미지 불러오기
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // 이미지 파일 이름을 아래에 표시 (확장자 제거)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              fileName,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
