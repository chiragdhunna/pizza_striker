import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

// Simple UserNewModel model for the hardcoded data
class UserNewModel {
  final int id;
  final String username;
  final String? avatarUrl;
  int strikes;

  UserNewModel({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.strikes = 0,
  });

  UserNewModel copyWith({
    int? id,
    String? username,
    String? avatarUrl,
    int? strikes,
  }) {
    return UserNewModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      strikes: strikes ?? this.strikes,
    );
  }
}

class _AdminScreenState extends State<AdminScreen> {
  late List<UserNewModel> usersData;
  late List<UserNewModel> owesPizzaUsers;
  TextEditingController searchController = TextEditingController();
  late List<UserNewModel> filteredUsers;

  @override
  void initState() {
    super.initState();
    // Initialize with hardcoded data
    usersData = [
      UserNewModel(id: 1, username: "Emily Davis", strikes: 2),
      UserNewModel(id: 2, username: "John Smith", strikes: 2),
      UserNewModel(id: 3, username: "Sarah Johnson", strikes: 2),
      UserNewModel(id: 4, username: "Michael Brown", strikes: 0),
      UserNewModel(id: 5, username: "Jessica Wilson", strikes: 0),
      UserNewModel(id: 6, username: "David Lee", strikes: 1),
      UserNewModel(id: 7, username: "Rebecca Moore", strikes: 0),
      UserNewModel(id: 8, username: "Jane Doe", strikes: 3),
    ];

    // Set initial filtered list
    filteredUsers = List.from(usersData);

    // Set the owes pizza users (ones with 3 strikes)
    updateOwesPizzaUsers();
  }

  void updateOwesPizzaUsers() {
    owesPizzaUsers =
        usersData.where((UserNewModel) => UserNewModel.strikes >= 3).toList();
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = usersData
          .where((UserNewModel) =>
              UserNewModel.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addStrike(UserNewModel UserNewModel) {
    setState(() {
      // Find and update the UserNewModel in the original list
      final index = usersData.indexWhere((u) => u.id == UserNewModel.id);
      if (index != -1) {
        usersData[index] =
            UserNewModel.copyWith(strikes: UserNewModel.strikes + 1);

        // Re-apply the current filter
        String currentSearchText = searchController.text;
        if (currentSearchText.isNotEmpty) {
          filterUsers(currentSearchText);
        } else {
          filteredUsers = List.from(usersData);
        }

        // Update the owes pizza section
        updateOwesPizzaUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Admin header
              Row(
                children: [
                  _buildLogo(isDarkMode),
                  const SizedBox(width: 12),
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Search bar
              _buildSearchBar(isDarkMode),
              const SizedBox(height: 24),

              // Owes Pizza section
              if (owesPizzaUsers.isNotEmpty) ...[
                Text(
                  'Owes Pizza',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Owes Pizza list
                ...owesPizzaUsers.map((UserNewModel) =>
                    _buildEmployeeCard(UserNewModel, isDarkMode, true)),
                const SizedBox(height: 24),
              ],

              // Employee List section
              Text(
                'Employee List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Employee list
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    return _buildEmployeeCard(
                        filteredUsers[index], isDarkMode, false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDarkMode) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode ? const Color(0xFF252525) : const Color(0xFFFEEBD0),
        border: Border.all(
          color: isDarkMode ? Colors.transparent : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.local_pizza,
            color: const Color(0xFFFF6B00),
            size: 24,
          ),
          Transform.rotate(
            angle: 2.3, // Approximately 135 degrees
            child: Container(
              width: 40,
              height: 2,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDarkMode) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextField(
        controller: searchController,
        onChanged: filterUsers,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Search employees',
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(
      UserNewModel UserNewModel, bool isDarkMode, bool isInOwesPizza) {
    // Show warning if this is about to be their third strike
    final showWarning = UserNewModel.strikes == 2;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: showWarning && isInOwesPizza
              ? isDarkMode
                  ? const Color(0xFF2C1E1A) // Dark warning background
                  : const Color(0xFFFFF4F2) // Light warning background
              : isDarkMode
                  ? const Color(0xFF1E1E1E)
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              // Employee avatar
              CircleAvatar(
                backgroundColor:
                    isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                child: Text(
                  UserNewModel.username.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Employee name and strikes
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UserNewModel.username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    if (showWarning && isInOwesPizza) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: const Color(0xFFE24E32), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "This will be the employee's third strike.",
                            style: TextStyle(
                              color: const Color(0xFFE24E32),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (UserNewModel.strikes > 0 &&
                        (!showWarning || !isInOwesPizza)) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          UserNewModel.strikes,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Icon(
                              Icons.local_pizza,
                              color: const Color(0xFFFF6B00),
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Add Strike button
              ElevatedButton(
                onPressed: () => addStrike(UserNewModel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE24E32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'Add Strike',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
