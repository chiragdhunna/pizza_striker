import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddStrikerScreen extends StatefulWidget {
  const AddStrikerScreen({super.key});

  @override
  State<AddStrikerScreen> createState() => _AddStrikerScreenState();
}

class _AddStrikerScreenState extends State<AddStrikerScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  int _strikeCount =
      2; // Default to 2 strikes (showing the third strike warning)
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize date controller with current date
    _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on theme with corrected values
    final backgroundColor = isDarkMode ? const Color(0xFF0F1729) : Colors.white;
    final cardColor = isDarkMode ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.grey;
    final inputBgColor =
        isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFF7F7F7);
    final warningBgColor =
        isDarkMode ? const Color(0xFF3D2A2A) : const Color(0xFFFEEDED);
    final buttonColor = const Color(0xFFFF5D32);
    final buttonTextColor = Colors.white;
    final borderColor = isDarkMode ? Colors.transparent : Colors.black12;

    // Avatar background colors
    final avatarBgColor = isDarkMode
        ? const Color(0xFF1E293B) // Corrected dark theme avatar background
        : const Color(0xFFFCE4DE); // Light theme avatar background

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Add Strike',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: !isDarkMode, // Center title only in light mode

        automaticallyImplyLeading:
            false, // Only use default back button in dark mode
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Center(
                child: Column(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: avatarBgColor,
                      child: ClipOval(
                        child: Image.asset(
                          isDarkMode
                              ? 'assets/profile_placeholder.png'
                              : 'assets/profile_placeholder_female.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 40,
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.orange[300],
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Name
                    Text(
                      isDarkMode ? 'John Doe' : 'Jane Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Current Strikes with centered pizza slices
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isDarkMode)
                          Text(
                            'Strikes',
                            style: TextStyle(
                              fontSize: 16,
                              color: subtitleColor,
                            ),
                          ),
                        const SizedBox(width: 8),
                        const Text('🍕', style: TextStyle(fontSize: 18)),
                        const Text('🍕', style: TextStyle(fontSize: 18)),
                        if (_strikeCount == 3)
                          const Text('🍕', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Reason Section
              Text(
                'Reason',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 8),

              // Reason Input Field
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: TextField(
                  controller: _reasonController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Enter the reason',
                    hintStyle: TextStyle(color: subtitleColor),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Warning Messages based on strike count
              if (_strikeCount == 2) // Show warning for third strike
                _buildWarningMessage(isDarkMode, warningBgColor,
                    "This will be the employee's third strike.")
              else if (_strikeCount == 3) // Already has 3 strikes
                _buildWarningMessage(isDarkMode, warningBgColor,
                    "Employee already owes the pizza."),

              const SizedBox(height: 16),

              // Date Section
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 8),

              // Date Input Field
              Container(
                decoration: BoxDecoration(
                  color: inputBgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: TextField(
                  controller: _dateController,
                  readOnly: true,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Select date',
                    hintStyle: TextStyle(color: subtitleColor),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today, color: subtitleColor),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                ),
              ),

              // Only show notifications section when strike count is 2
              if (isDarkMode && _strikeCount == 2) ...[
                const SizedBox(height: 24),

                // Notifications Section
                Text(
                  'NOTIFICATIONS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 16),

                // Notification Item
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Someone reaches 3 third',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue[400],
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle strike confirmation
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: buttonTextColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirm Strike',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningMessage(bool isDarkMode, Color bgColor, String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFFF5D32),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : const Color(0xFFFF5D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text('🍕', style: TextStyle(fontSize: 18)),
                    Text('🍕', style: TextStyle(fontSize: 18)),
                    Text('🍕', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
