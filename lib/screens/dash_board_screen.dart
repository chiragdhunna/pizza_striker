import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../logic/older_models/old_user_model.dart';
import 'package:pizza_striker/screens/strike_details.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key, required this.user});

  final User user;

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Colors based on theme
    final Color primaryColor = isDarkMode ? Colors.orange : Colors.deepOrange;
    final Color secondaryColor =
        isDarkMode ? Colors.orange.shade300 : Colors.orange;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color cardBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color subTextColor =
        isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(0), // or try 1 if 0 causes layout issues
        child: AppBar(
          backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
          shadowColor: Colors.transparent, // eliminate elevation shadow
          surfaceTintColor: Colors.transparent, // for Material 3 themes
          elevation: 0, // no shadow
          toolbarHeight: 0, // removes any toolbar render space
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section with pizza logo
              Center(
                child: Column(
                  children: [
                    // Pizza logo with lightning
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.asset(isDarkMode
                            ? 'assets/pizza_striker_logo_dark.png'
                            : 'assets/pizza_striker_logo_light.png'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User name
                    Text(
                      widget.user.username,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Strikes indicator
              Card(
                color: cardBackgroundColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Strikes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First pizza slice (filled)
                          _buildPizzaSlice(true, primaryColor),
                          const SizedBox(width: 8),
                          // Empty pizza slices
                          _buildPizzaSlice(
                              false, primaryColor.withOpacity(0.3)),
                          const SizedBox(width: 8),
                          _buildPizzaSlice(
                              false, primaryColor.withOpacity(0.3)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Strike count
                      Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Strike History
              Card(
                color: cardBackgroundColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Strike History',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Strike history list items
                      _buildStrikeHistoryItem('Apr 5, 2024', 'Late for shift',
                          textColor, subTextColor),
                      Divider(color: subTextColor.withOpacity(0.3)),
                      _buildStrikeHistoryItem('Apr 5, 2024', 'Late for shift',
                          textColor, subTextColor),
                      Divider(color: subTextColor.withOpacity(0.3)),
                      _buildStrikeHistoryItem('Apr 5, 2024', 'Late for shift',
                          textColor, subTextColor),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // // Owes Pizza section
              // Card(
              //   color: cardBackgroundColor,
              //   elevation: 4,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Owes Pizza',
              //           style: TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.bold,
              //             color: primaryColor,
              //           ),
              //         ),
              //         const SizedBox(height: 16),
              //         // Person who is owed pizza
              //         Text(
              //           'Alice Smith',
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //             color: textColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: cardBackgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: subTextColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildStrikeHistoryItem(
      String date, String reason, Color textColor, Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            reason,
            style: TextStyle(
              fontSize: 16,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Pizza painter for the logo
class PizzaPainter extends CustomPainter {
  final Color color;

  PizzaPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw pizza circles (pepperoni)
    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.3), size.width * 0.08, paint);
    canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.3), size.width * 0.08, paint);
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5), size.width * 0.08, paint);
    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.7), size.width * 0.08, paint);
    canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.7), size.width * 0.08, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget _buildPizzaSlice(bool isFilled, Color color) {
  return SizedBox(
    width: 60,
    height: 60,
    child: CustomPaint(
      painter: isFilled ? FilledPizzaSlicePainter() : EmptyPizzaSlicePainter(),
    ),
  );
}

// Pizza slice painter for filled slices
class FilledPizzaSlicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Pizza base triangle
    Path trianglePath = Path()
      ..moveTo(0, 0) // Top left
      ..lineTo(size.width, 0) // Top right
      ..lineTo(size.width / 2, size.height) // Bottom middle
      ..close();

    // Base pizza color - orange
    final Paint pizzaBasePaint = Paint()
      ..color = const Color(0xFFFF9B34)
      ..style = PaintingStyle.fill;

    // Draw pizza base
    canvas.drawPath(trianglePath, pizzaBasePaint);

    // Draw crust border at the bottom
    final Paint crustPaint = Paint()
      ..color = const Color(0xFFDD5D28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    Path crustPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
          size.width / 2,
          -size.height * 0.2, // control point
          size.width,
          0 // end point
          );
    canvas.drawPath(crustPath, crustPaint);

    // Draw pepperoni toppings
    final Paint pepperoniPaint = Paint()
      ..color = const Color(0xFFD73C26)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.33, size.height * 0.3),
        size.width * 0.08, pepperoniPaint);
    canvas.drawCircle(Offset(size.width * 0.67, size.height * 0.3),
        size.width * 0.08, pepperoniPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6),
        size.width * 0.08, pepperoniPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Pizza slice painter for empty slices
class EmptyPizzaSlicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Pizza base triangle
    Path trianglePath = Path()
      ..moveTo(0, 0) // Top left
      ..lineTo(size.width, 0) // Top right
      ..lineTo(size.width / 2, size.height) // Bottom middle
      ..close();

    // Based on image, the empty slice is dark gray
    final Paint pizzaBasePaint = Paint()
      ..color = const Color(0xFF333333)
      ..style = PaintingStyle.fill;

    // Draw pizza base
    canvas.drawPath(trianglePath, pizzaBasePaint);

    // Draw crust border - slightly darker than base
    final Paint crustPaint = Paint()
      ..color = const Color(0xFF222222)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    Path crustPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
          size.width / 2,
          -size.height * 0.2, // control point
          size.width,
          0 // end point
          );
    canvas.drawPath(crustPath, crustPaint);

    // Draw pepperoni circle outlines
    final Paint pepperoniPaint = Paint()
      ..color = const Color(0xFF444444)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.33, size.height * 0.3),
        size.width * 0.08, pepperoniPaint);
    canvas.drawCircle(Offset(size.width * 0.67, size.height * 0.3),
        size.width * 0.08, pepperoniPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6),
        size.width * 0.08, pepperoniPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
