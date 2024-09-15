import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/widgets/materials_in_refri.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> materialsTrue = ["감자", "양파"];
    List<String> materialsFalse = ["감자", "양파", "애호박", "김치", "돼지고기", "닭고기"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          '레시피 이름',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: txtColor_1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.star_border,
              size: 30,
              color: HexColor('#D9D9D9'),
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0.5,
        shadowColor: HexColor('#E3E3E3'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 17.0),
              child: Text('조리시간 : {nn}분'),
            ),
            Divider(
              color: HexColor('#F1F1F1'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '재료',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Row(
                      children: materialsTrue
                          .map((material) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: materialsInRefri(material),
                              ))
                          .toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: materialsFalse
                          .map((material) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: materialsInRefri(material),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: HexColor('#F1F1F1'),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '레시피',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP 1',
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '청양고추와 파는 쫑쫑 썰어놓는다',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                              style: TextStyle(
                                color: txtColor_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP 2',
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '모든 재료를 큼직하게 썰어놓는다',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                              style: TextStyle(
                                color: txtColor_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP 3',
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '냄비에 물을 2/3정도 넣고 된장과 멸치가루를 풀어 끓기 시작하면 감자, 양파, 새송이버섯을 넣고 끓여줍니다',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                              style: TextStyle(
                                color: txtColor_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP 4',
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '감자가 적당히 익었으면 두부, 파, 청양고추, 마늘, 고춧가루를 넣고 한번더 끓입니다',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                              style: TextStyle(
                                color: txtColor_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP 5',
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '감자가 부서지지 않도록 끓여서 뚝배기에 담아주면 완성!',
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                              style: TextStyle(
                                color: txtColor_1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: HexColor('#D9D9D9')),
                ),
              ),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    '영상 보기',
                    style: TextStyle(
                      color: HexColor('#FFFFFF'),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
