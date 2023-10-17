import 'package:flutter/material.dart';

import '../colors.dart';

class SocialContainer extends StatelessWidget {
  SocialContainer({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.onPress,
  });
  String imgUrl;
  String title;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: s.width * 0.44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.socialContainerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: s.width * 0.1,
                child: Image(
                  image: AssetImage(imgUrl),
                ),
              ),
              const SizedBox(width: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
