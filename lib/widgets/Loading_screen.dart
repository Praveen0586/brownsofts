import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool isLoading;
  final Color backgroundColor;

  LoadingScreen({required this.isLoading, this.backgroundColor = Colors.brown});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text('Not Loading', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
