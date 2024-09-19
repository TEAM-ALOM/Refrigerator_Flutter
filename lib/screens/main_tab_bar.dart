import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:refrigerator_frontend/screens/bookmark_screen.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';
import 'package:refrigerator_frontend/screens/roulette_screen.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key}); // 탭 바

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          // 각 탭별 페이지
          children: [
            Center(
              child: HomeScreen(),
            ),
            Center(
              child: SearchScreen(),
            ),
            Center(
              child: BookMarkScreen(),
            ),
          ],
        ),
        bottomNavigationBar: PreferredSize(
          //하단 탭바 (바텀 네비게이션 바 역할)
          preferredSize: const Size.fromHeight(85),
          child: Container(
            height: 85,
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: background,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 15.0,
                  spreadRadius: 5.0,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: TabBar(
              tabs: const [
                Tab(
                  icon: Icon(Icons.home_outlined),
                  child: SizedBox(height: 30),
                ),
                Tab(
                  icon: Icon(Icons.search),
                  child: SizedBox(height: 30),
                ),
                Tab(
                  icon: Icon(Icons.star_border),
                  child: SizedBox(height: 30),
                ),
              ],
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: selectedIconColor,
              unselectedLabelColor: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
