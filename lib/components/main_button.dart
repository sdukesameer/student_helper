import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_helper/helpers/font_size.dart';
import 'package:student_helper/helpers/theme_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Color? backGroundColor, textColor;
  final Function() onTap;
  const MainButton({
    Key? key,
    required this.text,
    this.backGroundColor,
    this.textColor,
    required this.onTap,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backGroundColor == null
              ? ThemeColors.primaryColor
              : backGroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconPath == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image(
                        image: AssetImage(iconPath!),
                        height: 30,
                      ),
                    ),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: textColor == null
                      ? ThemeColors.whiteTextColor
                      : textColor,
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
