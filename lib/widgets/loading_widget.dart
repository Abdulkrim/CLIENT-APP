import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool _isCircularProgress;

  const LoadingWidget({super.key}) : _isCircularProgress = true;
  const LoadingWidget.iosMode({super.key}) : _isCircularProgress = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isCircularProgress ? const CircularProgressIndicator() : const CupertinoActivityIndicator(),
      ),
    );
  }
}
