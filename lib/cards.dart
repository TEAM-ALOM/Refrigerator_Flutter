import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

// 라벨 있는 카드
class IngredientCard extends StatelessWidget {
  IngredientCard({
    super.key,
    required this.color,
    required this.name,
    required this.path,
  });

  Color color;
  String name;
  String path;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: color,
      elevation: 0,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: SvgPicture.asset(
                'assets/images/ingredients/$path.svg',
                height: 50,
                width: 50,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: HexColor('#303030'),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 라벨 없는 카드
class IngredientCardWithoutLabel extends StatelessWidget {
  IngredientCardWithoutLabel({
    super.key,
    required this.color,
    required this.path,
  });

  Color color;
  String path;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: color,
      elevation: 0,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 9.0,
          ),
          child: SvgPicture.asset(
            'assets/images/ingredients/$path.svg',
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }
}
