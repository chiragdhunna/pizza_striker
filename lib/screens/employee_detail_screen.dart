import 'package:flutter/material.dart';
import 'package:pizza_striker/logic/older_models/admin_model.dart';
import 'package:pizza_striker/logic/api/user/models/user_model.dart';

import '../logic/older_models/old_user_model.dart';

class EmployeeDetailScreen extends StatelessWidget {
  User? user;
  Admin? admin;

  EmployeeDetailScreen({super.key, this.user, this.admin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.name),
      ),
      body: Center(
        child: Text('Details for $user'),
      ),
    );
  }
}
