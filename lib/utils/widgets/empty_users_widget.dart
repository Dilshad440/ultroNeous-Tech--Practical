import 'package:flutter/material.dart';
import 'package:ultroneous_practical/utils/app_style.dart';

class EmptyUserWidget extends StatelessWidget {
  const EmptyUserWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.emptyStyle,
      ),
    );
  }
}
