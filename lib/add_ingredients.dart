import 'package:flutter/material.dart';
import 'package:refrigerator_frontend/search_ingredients.dart';
import 'package:refrigerator_frontend/home.dart';

final List<String> imagePaths = [
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
];




class AddIngredientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('검색'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchIngredientsScreen()));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            ExpansionTile(
              title: Text('가공/유제품'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('고기'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('곡물'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('과일'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('면'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('빵/떡'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('음료/주류'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('채소'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('콩/견과류'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('해산물'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
            ExpansionTile(
              title: Text('조미료/양념'),
              // backgroundColor: Colors.blue[50],
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
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagePaths[index], // 로컬 이미지 불러오기
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              initiallyExpanded: true,
            ),
          ],
        )
    );
  }
}
