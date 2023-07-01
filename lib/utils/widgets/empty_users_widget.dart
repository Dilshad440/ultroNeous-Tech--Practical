import 'package:flutter/material.dart';
import 'package:ultroneous_practical/utils/app_style.dart';

class EmptyUserWidget extends StatelessWidget {
  const EmptyUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No users in favourite",
        style: AppTextStyle.emptyStyle,
      ),
    );
  }
}
