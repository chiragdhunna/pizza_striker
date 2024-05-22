import 'package:flutter/material.dart';
import 'package:pizza_striker/screens/strike_details.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
          Expanded(
            flex: 2,
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Mon', 35),
                    SalesData('Tues', 28),
                    SalesData('Wed', 34),
                    SalesData('Thurs', 32),
                    SalesData('Fri', 40),
                    SalesData('Sat', 40)
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                )
              ],
            ),
          ),
          Expanded(flex: 3, child: _buildStrikeList(context)),
        ],
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
