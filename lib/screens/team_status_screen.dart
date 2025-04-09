import 'package:flutter/material.dart';

class TeamStatusScreen extends StatefulWidget {
  const TeamStatusScreen({super.key});

  @override
  State<TeamStatusScreen> createState() => _TeamStatusScreenState();
}

class _TeamStatusScreenState extends State<TeamStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Theme-specific colors
    final backgroundColor = isDarkMode ? const Color(0xFF0A1929) : Colors.white;
    final cardColor =
        isDarkMode ? const Color(0xFF3D2314) : const Color(0xFFCF7946);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor =
        isDarkMode ? const Color(0xFFE69B3A) : const Color(0xFFD39339);
    final dividerColor = isDarkMode ? Colors.white24 : Colors.black12;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? const Color(0xFF1F3251)
                      : const Color(0xFFF5F5F5),
                  border: Border.all(color: const Color(0xFFE69B3A), width: 2),
                ),
                child: Center(
                  child: _buildLogoContent(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              "TEAM STATUS",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),
            // User Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDarkMode
                            ? const Color(0xFF301809)
                            : const Color(0xFFE69B3A),
                      ),
                      child: Center(
                        child: _buildAvatarPlaceholder(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // User info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Owes Pizza",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: subtitleColor,
                          ),
                        ),
                        Text(
                          "Emily Davis",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: subtitleColor,
                          ),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: _buildPizzaSlice(),
                              ),
                          ],
                        ),
                        isDarkMode
                            ? Text(
                                "By Apr 30, 2024",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange[300],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Team Members List - Wrapped in Expanded to avoid overflow
            Expanded(
              child: isDarkMode
                  ? _buildDarkModeTeamList()
                  : _buildLightModeTeamList(dividerColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeTeamList() {
    final teamMembers = [
      {"name": "John Smith", "pizza": 2},
      {"name": "Sarah Johnson", "pizza": 0},
      {"name": "Michael Brown", "pizza": 2},
      {"name": "Jessica Wilson", "pizza": 1},
      {"name": "David Martinez", "pizza": 1},
      {"name": "Amanda Taylor", "pizza": 2},
      {"name": "Olivia White", "pizza": 1},
      {"name": "James Anderson", "pizza": 1},
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: teamMembers.length,
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white24),
      itemBuilder: (context, index) {
        final member = teamMembers[index];
        final name = member["name"] as String;
        final pizzaCount = member["pizza"] as int;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              pizzaCount == 0
                  ? const Text(
                      "0",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white54,
                      ),
                    )
                  : Row(
                      children: [
                        for (int i = 0; i < pizzaCount; i++)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: _buildPizzaSlice(size: 20),
                          ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLightModeTeamList(Color dividerColor) {
    // Using ListView instead of Column to make it scrollable
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // First Card - Notifications
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationHeader(),
              const SizedBox(height: 8),
              _buildTeamMember("John Smith", 1),
              Divider(color: dividerColor),
              _buildTeamMember("Sarah Johnson", 0),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Second Card - Areas Pizza
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAreaHeader(),
              const SizedBox(height: 8),
              _buildTeamMember("John Smith", 1),
              Divider(color: dividerColor),
              _buildTeamMember("Sarah Johnson", 0),
              Divider(color: dividerColor),
              _buildTeamMember("Michael Brown", 1),
              Divider(color: dividerColor),
              _buildTeamMember("Jessica Wilson", 1, isNumber: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationHeader() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "NOTIFICATIONS",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFCF7946),
        ),
      ),
    );
  }

  Widget _buildAreaHeader() {
    return const Text(
      "AREAS PIZZA",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFCF7946),
      ),
    );
  }

  Widget _buildTeamMember(String name, int pizzaCount,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          pizzaCount == 0
              ? const Text(
                  "0",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : isNumber
                  ? const Text(
                      "1",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : _buildPizzaSlice(size: 24),
        ],
      ),
    );
  }

  Widget _buildLogoContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE89E42),
          ),
        ),
        CustomPaint(
          size: const Size(40, 40),
          painter: PizzaSlicePainter(),
        ),
        CustomPaint(
          size: const Size(24, 24),
          painter: LightningBoltPainter(),
        ),
      ],
    );
  }

  Widget _buildAvatarPlaceholder() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.orange[300]! : Colors.white;

    return Icon(
      Icons.person_outline,
      size: 36,
      color: iconColor,
    );
  }

  Widget _buildPizzaSlice({double size = 24}) {
    return Image.asset(
      'assets/images/pizza_slice.png',
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        // Fallback when image asset is not available
        return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
          child: Center(
            child: Transform.rotate(
              angle: -0.8,
              child: Icon(
                Icons.local_pizza,
                size: size * 0.7,
                color: Colors.orangeAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}

class PizzaSlicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw pizza with slices
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Draw slice lines
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(
      center,
      Offset(size.width, size.height / 2),
      paint,
    );
    canvas.drawLine(
      center,
      Offset(size.width / 2, 0),
      paint,
    );

    // Pizza toppings
    final toppingPaint = Paint()
      ..color = Colors.red[700]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.3),
      size.width * 0.05,
      toppingPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.65),
      size.width * 0.05,
      toppingPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LightningBoltPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.7, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
