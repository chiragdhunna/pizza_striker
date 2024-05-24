import 'package:flutter/material.dart';
import 'package:pizza_striker/db_helper.dart';
import 'package:pizza_striker/logic/models/user_model.dart';
import 'package:pizza_striker/screens/employee_detail_screen.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final List<String> employees = ['John Doe', 'Jane Smith'];
  final db = DBHelper();
  List<User> usersData = [];

  @override
  void initState() {
    // TODO: implement initState
    db.database;
    db.readAllUser().then((value) {
      usersData = value;
      log.w('Value is $usersData');
      setState(() {});
    });
    super.initState();
  }

  // Example data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: _buildDrawer(context),
      body: ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(usersData[index].username),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmployeeDetailScreen(user: usersData[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
    );
  }
}
