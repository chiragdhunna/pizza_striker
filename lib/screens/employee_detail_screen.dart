import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final String employeeName;

  const EmployeeDetailScreen({super.key, required this.employeeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employeeName),
      ),
      body: Center(
        child: Text('Details for $employeeName'),
      ),
    );
  }
}
