import 'package:flutter/material.dart';

class StrikeDetailScreen extends StatelessWidget {
  final String date;
  final int strikes;

  const StrikeDetailScreen(
      {super.key, required this.date, required this.strikes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strike Details on $date'),
      ),
      body: Center(
        child: Text('Number of strikes on $date: $strikes'),
      ),
    );
  }
}
