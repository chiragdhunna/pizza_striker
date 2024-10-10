import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pizza_striker/screens/strike_details.dart';
import 'package:intl/intl.dart';

import '../logic/older_models/old_user_model.dart';

String randomDates() {
  final date = Random().nextInt(30);
  final month = Random().nextInt(12);
  // final year = Random().nextInt(2024) + 1900;
  final year = 1900 + (Random(1).nextInt(2024 - 1900));
  final randomDate = DateTime(year, month, date);
  return DateFormat('yyyy-MM-dd - kk:mm').format(randomDate);
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.user});

  final User user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
      body: Column(
        children: [
          const Text(
            'Strike History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final date = randomDates();
                  return Card(
                    child: ListTile(
                      title: const Text('Reason'),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/id/${Random().nextInt(500)}/200/300')),
                      subtitle: const Text('Subtitle'),
                      trailing: Text(date),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StrikeDetailScreen(date: date, strikes: 1)));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/id/${Random().nextInt(500)}/200/300',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.user.username,
                    ),
                  ],
                )
              ],
            ),
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

  Widget _buildStrikeList(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final day = DateTime.now().subtract(Duration(days: index));
        final formattedDate = "${day.day}/${day.month}/${day.year}";
        final strikes = (index * 12345) % 5 + 1; // Dummy data
        return Card(
          child: ListTile(
            title: Text("Strikes on $formattedDate: $strikes"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StrikeDetailScreen(date: formattedDate, strikes: strikes),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
