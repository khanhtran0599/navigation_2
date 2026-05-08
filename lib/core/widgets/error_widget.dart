import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_button.dart';

class MyErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onReTry;
  const MyErrorWidget({super.key, this.message = "Error", this.onReTry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(message),
          MyButtonPrimary(
            title: 'Thử lại',
            paddingHorizontal: 30,
            onPress: onReTry ?? () {},
          ),
        ],
      ),
    );
  }
}
