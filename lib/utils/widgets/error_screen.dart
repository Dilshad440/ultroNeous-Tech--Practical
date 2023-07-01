import 'package:flutter/material.dart';
import 'package:ultroneous_practical/utils/app_style.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: AppTextStyle.emptyStyle,
      ),
    );
  }
}
