import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/sign_in_screen.dart';

class CustomTextFormField extends StatelessWidget {
  //  텍스트 필드 커스텀한 거
  String hintText;
  Widget? sufficIcon;
  FormFieldValidator validator; // 유효성 검사

  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.sufficIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: sufficIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: txtColor_2,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#D9D9D9'),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#D9D9D9'),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#DB4533'),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#DB4533'),
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      cursorColor: txtColor_2,
    );
  }
}
