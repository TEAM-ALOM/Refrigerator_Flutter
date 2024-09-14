import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late TextEditingController textController;
  String textContent = "";

  int? _value;
  List<String> categories = ['한식', '양식', '베트남 음식', '메인 요리'];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(15),
        child: AppBar(
          backgroundColor: background,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                  hintText: '냉장고의 꿈',
                  hintStyle: TextStyle(
                    color: primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '추천 레시피',
                  style: TextStyle(
                    color: txtColor_1,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: 217,
                    width: 351,
                    child: Image.asset('assets/images/고등어무조림.png')),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '카테고리',
                  style: TextStyle(
                    color: txtColor_1,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: List<Widget>.generate(categories.length, (index) {
                    return ChoiceChip(
                      label: Text(
                        categories[index],
                      ),
                      selected: _value == index,
                      selectedColor: Colors.blue[100],
                      backgroundColor: background,
                      showCheckmark: false,
                      side: BorderSide(
                        color: HexColor('D9D9D9'),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;
                        });
                      },
                    );
                  }),
                )
              ],
            ),
            // ListView.builder(
            //   itemCount: 20,
            //   itemBuilder: ((context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(3),
            //       child: ListTile(
            //         title: Text('Item ${index + 1}',
            //             style: const TextStyle(fontSize: 18)),
            //       ),
            //     );
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
