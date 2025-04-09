# Pizza Striker Application Structure

## System Architecture

### User Roles

1. **Admin** - Can assign strikes to regular employees and the other admin
2. **Employee** - Regular users who can receive strikes

### Core Features

1. Strike assignment and tracking
2. User authentication and role management
3. Notification system
4. Analytics dashboard
5. Pizza event tracking

## Database Design

### Users Collection

```
{
  _id: ObjectId,
  username: String,
  password: String (hashed),
  email: String,
  fullName: String,
  role: String (enum: "Admin", "Employee"),
  adminPairId: ObjectId (only for admins, references the other admin),
  department: String,
  joinedDate: Date,
  profileImage: String (URL),
  isActive: Boolean
}
```

### Strikes Collection

```
{
  _id: ObjectId,
  userId: ObjectId (reference to Users),
  assignedBy: ObjectId (reference to Users - admin who assigned),
  reason: String,
  description: String,
  date: Date,
  acknowledged: Boolean,
  status: String (enum: "Active", "Pardoned", "Expired")
}
```

### Pizza Events Collection

```
{
  _id: ObjectId,
  userId: ObjectId (reference to Users),
  date: Date,
  pizzaType: String,
  cost: Number,
  participants: [ObjectId] (references to Users),
  photos: [String] (URLs),
  status: String (enum: "Scheduled", "Completed", "Canceled")
}
```

### Notifications Collection

```
{
  _id: ObjectId,
  userId: ObjectId (reference to Users),
  type: String (enum: "Strike", "PizzaDue", "StrikeReminder", "AdminAction"),
  message: String,
  date: Date,
  read: Boolean,
  relatedDocumentId: ObjectId (reference to the relevant document)
}
```

## Backend Structure (Node.js/Express)

### Directory Structure

```
pizza-striker-api/
│
├── node_modules/
├── src/
│   ├── config/
│   │   ├── database.js         # Database connection config
│   │   ├── authentication.js   # JWT and security config
│   │   └── app.js             # Main application config
│   │
│   ├── models/
│   │   ├── user.model.js
│   │   ├── strike.model.js
│   │   ├── pizza-event.model.js
│   │   └── notification.model.js
│   │
│   ├── controllers/
│   │   ├── auth.controller.js
│   │   ├── user.controller.js
│   │   ├── strike.controller.js
│   │   ├── pizza-event.controller.js
│   │   ├── notification.controller.js
│   │   └── admin.controller.js
│   │
│   ├── routes/
│   │   ├── auth.routes.js
│   │   ├── user.routes.js
│   │   ├── strike.routes.js
│   │   ├── pizza-event.routes.js
│   │   ├── notification.routes.js
│   │   └── admin.routes.js
│   │
│   ├── middleware/
│   │   ├── auth.middleware.js      # JWT verification
│   │   ├── role.middleware.js      # Role-based access control
│   │   ├── admin.middleware.js     # Admin-specific rules
│   │   └── error.middleware.js     # Error handling
│   │
│   ├── utils/
│   │   ├── password.utils.js       # Password hashing
│   │   ├── token.utils.js          # JWT generation/validation
│   │   ├── notification.utils.js   # Push notification helpers
│   │   └── validation.utils.js     # Input validation
│   │
│   └── server.js                   # Entry point
│
├── .env                            # Environment variables
├── .gitignore
├── package.json
└── README.md
```

### API Endpoints

#### Authentication

- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `POST /api/auth/refresh-token` - Refresh JWT
- `POST /api/auth/logout` - User logout
- `GET /api/auth/me` - Get current user

#### Users

- `GET /api/users` - Get all users (admin only)
- `GET /api/users/:id` - Get single user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Deactivate user (admin only)
- `GET /api/users/:id/strikes` - Get user strikes

#### Strikes

- `POST /api/strikes` - Create new strike (admin only)
- `GET /api/strikes` - Get all strikes (admin only)
- `GET /api/strikes/:id` - Get strike details
- `PUT /api/strikes/:id` - Update strike (admin only)
- `DELETE /api/strikes/:id` - Remove strike (admin only)

#### Pizza Events

- `POST /api/pizza-events` - Schedule pizza event
- `GET /api/pizza-events` - Get all pizza events
- `GET /api/pizza-events/:id` - Get event details
- `PUT /api/pizza-events/:id` - Update event
- `POST /api/pizza-events/:id/complete` - Mark event as completed

#### Notifications

- `GET /api/notifications` - Get user notifications
- `PUT /api/notifications/:id/read` - Mark notification as read
- `DELETE /api/notifications/:id` - Delete notification

#### Admin

- `GET /api/admin/dashboard` - Get admin dashboard stats
- `GET /api/admin/users` - Get expanded user management data
- `POST /api/admin/assign` - Assign admin role to user

### Middleware Implementation Details

#### auth.middleware.js

```javascript
const jwt = require("jsonwebtoken");
const { JWT_SECRET } = process.env;

module.exports = (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];

  if (!token) {
    return res.status(401).json({ message: "Authentication required" });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid or expired token" });
  }
};
```

#### role.middleware.js

```javascript
module.exports = (role) => {
  return (req, res, next) => {
    if (req.user && req.user.role === role) {
      return next();
    }
    return res
      .status(403)
      .json({ message: "Access denied. Insufficient privileges." });
  };
};
```

#### admin.middleware.js

```javascript
const User = require("../models/user.model");

module.exports = async (req, res, next) => {
  try {
    // For strike assignments, check if admin is trying to give themselves a strike
    if (req.body.userId && req.body.userId === req.user.id) {
      return res
        .status(403)
        .json({ message: "Admins cannot assign strikes to themselves" });
    }

    // Check if admin is assigning to another admin that's not their pair
    if (req.body.userId) {
      const targetUser = await User.findById(req.body.userId);
      if (
        targetUser.role === "Admin" &&
        targetUser.adminPairId !== req.user.id
      ) {
        return res
          .status(403)
          .json({ message: "You can only assign strikes to your admin pair" });
      }
    }

    next();
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Server error", error: error.message });
  }
};
```

## Frontend Structure (Flutter)

### Directory Structure

```
pizza_striker/
│
├── android/                    # Android-specific files
├── ios/                        # iOS-specific files
├── web/                        # Web-specific files
│
├── lib/
│   ├── main.dart               # Application entry point
│   │
│   ├── config/
│   │   ├── app_config.dart     # App configuration
│   │   ├── themes.dart         # App theming
│   │   └── routes.dart         # App navigation routes
│   │
│   ├── models/
│   │   ├── user.dart
│   │   ├── strike.dart
│   │   ├── pizza_event.dart
│   │   └── notification.dart
│   │
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── user_provider.dart
│   │   ├── strike_provider.dart
│   │   ├── pizza_event_provider.dart
│   │   └── notification_provider.dart
│   │
│   ├── services/
│   │   ├── api_service.dart    # API client
│   │   ├── auth_service.dart   # Authentication logic
│   │   ├── storage_service.dart # Local storage
│   │   └── notification_service.dart # Push notifications
│   │
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   │
│   │   ├── dashboard/
│   │   │   ├── employee_dashboard.dart
│   │   │   └── admin_dashboard.dart
│   │   │
│   │   ├── strikes/
│   │   │   ├── strikes_list_screen.dart
│   │   │   ├── strike_detail_screen.dart
│   │   │   └── assign_strike_screen.dart
│   │   │
│   │   ├── pizza_events/
│   │   │   ├── pizza_events_screen.dart
│   │   │   ├── pizza_event_detail_screen.dart
│   │   │   └── schedule_pizza_screen.dart
│   │   │
│   │   ├── profile/
│   │   │   ├── profile_screen.dart
│   │   │   └── edit_profile_screen.dart
│   │   │
│   │   ├── users/
│   │   │   ├── users_list_screen.dart
│   │   │   └── user_detail_screen.dart
│   │   │
│   │   └── notifications/
│   │       └── notifications_screen.dart
│   │
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── app_bar.dart
│   │   │   ├── drawer.dart
│   │   │   ├── loading_indicator.dart
│   │   │   ├── error_dialog.dart
│   │   │   └── confirmation_dialog.dart
│   │   │
│   │   ├── auth/
│   │   │   ├── login_form.dart
│   │   │   └── register_form.dart
│   │   │
│   │   ├── strikes/
│   │   │   ├── strike_card.dart
│   │   │   └── strike_form.dart
│   │   │
│   │   ├── users/
│   │   │   ├── user_card.dart
│   │   │   └── user_strikes_summary.dart
│   │   │
│   │   └── pizza_events/
│   │       ├── pizza_event_card.dart
│   │       └── pizza_event_form.dart
│   │
│   └── utils/
│       ├── validators.dart      # Form validation
│       ├── date_formatter.dart  # Date formatting
│       ├── dialog_utils.dart    # Dialog helpers
│       └── constants.dart       # App constants
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   ├── pizza.png
│   │   └── strike.png
│   │
│   └── fonts/
│       └── custom_icons.ttf
│
├── pubspec.yaml                # Flutter dependencies
└── README.md
```

### Key Screens and UI Components

#### Login Screen

- Username/email and password fields
- Login button
- Forgot password link
- Register link
- Remember me checkbox
- Logo and branding

#### Admin Dashboard

- Summary cards showing:
  - Total active employees
  - Total strikes assigned this month
  - Upcoming pizza events
  - Employees with 2+ strikes
- Quick actions:
  - Assign new strike
  - Manage users
  - View all strikes
- Recent activity feed
- Admin stats comparison (strikes given by each admin)

#### Employee Dashboard

- Personal strike count with visual indicator (0-3)
- Recent strikes received
- Upcoming pizza obligations (if any)
- Team strike leaderboard
- Notification center

#### Assign Strike Screen

- User selection dropdown/search
- Reason input field
- Description textarea
- Date picker
- Evidence upload (optional)
- Submit and cancel buttons
- Preview of user's current strike count

#### Strike List Screen

- Filter options (by user, date range, status)
- Sort options
- List of strike cards showing:
  - User name and avatar
  - Strike reason
  - Date assigned
  - Assigned by
  - Status indicator
- For admins: options to edit or remove strikes

#### Pizza Event Screen

- Calendar view of scheduled events
- List view of past events
- Event details showing:
  - User responsible
  - Pizza type
  - Date and time
  - Cost
  - Participants
  - Photos (for completed events)
- Options to mark event as completed

### State Management

Using Provider package for state management:

#### auth_provider.dart

```dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.role == 'Admin';

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await AuthService().login(username, password);
      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService().logout();
    _currentUser = null;
    notifyListeners();
  }

  // Other auth methods...
}
```

#### strike_provider.dart

```dart
import 'package:flutter/foundation.dart';
import '../models/strike.dart';
import '../services/api_service.dart';

class StrikeProvider with ChangeNotifier {
  List<Strike> _strikes = [];
  bool _isLoading = false;
  String? _error;

  List<Strike> get strikes => _strikes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadStrikes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _strikes = await ApiService().getStrikes();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> assignStrike(Strike strike) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newStrike = await ApiService().createStrike(strike);
      _strikes.add(newStrike);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Other methods for updating, deleting strikes...
}
```

## API Service Implementation

### api_service.dart

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/strike.dart';
import '../models/pizza_event.dart';
import '../services/storage_service.dart';

class ApiService {
  final String baseUrl = 'https://api.pizzastriker.com/api'; // Change to your actual API URL
  final StorageService _storage = StorageService();

  // Helper method to get headers with auth token
  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Authentication
  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.saveToken(data['token']);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Users
  Future<List<User>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Strikes
  Future<List<Strike>> getStrikes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/strikes'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((strike) => Strike.fromJson(strike)).toList();
    } else {
      throw Exception('Failed to load strikes');
    }
  }

  Future<Strike> createStrike(Strike strike) async {
    final response = await http.post(
      Uri.parse('$baseUrl/strikes'),
      headers: await _getHeaders(),
      body: jsonEncode(strike.toJson()),
    );

    if (response.statusCode == 201) {
      return Strike.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create strike: ${response.body}');
    }
  }

  // Pizza Events
  Future<List<PizzaEvent>> getPizzaEvents() async {
    final response = await http.get(
      Uri.parse('$baseUrl/pizza-events'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((event) => PizzaEvent.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load pizza events');
    }
  }

  // Add methods for all other API endpoints...
}
```

## Model Classes

### user.dart

```dart
class User {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String role;
  final String? adminPairId;
  final String department;
  final DateTime joinedDate;
  final String? profileImage;
  final bool isActive;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    this.adminPairId,
    required this.department,
    required this.joinedDate,
    this.profileImage,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
      adminPairId: json['adminPairId'],
      department: json['department'],
      joinedDate: DateTime.parse(json['joinedDate']),
      profileImage: json['profileImage'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'role': role,
      'adminPairId': adminPairId,
      'department': department,
      'joinedDate': joinedDate.toIso8601String(),
      'profileImage': profileImage,
      'isActive': isActive,
    };
  }
}
```

### strike.dart

```dart
class Strike {
  final String? id;
  final String userId;
  final String assignedBy;
  final String reason;
  final String description;
  final DateTime date;
  final bool acknowledged;
  final String status;

  Strike({
    this.id,
    required this.userId,
    required this.assignedBy,
    required this.reason,
    required this.description,
    required this.date,
    this.acknowledged = false,
    this.status = 'Active',
  });

  factory Strike.fromJson(Map<String, dynamic> json) {
    return Strike(
      id: json['_id'],
      userId: json['userId'],
      assignedBy: json['assignedBy'],
      reason: json['reason'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      acknowledged: json['acknowledged'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'assignedBy': assignedBy,
      'reason': reason,
      'description': description,
      'date': date.toIso8601String(),
      'acknowledged': acknowledged,
      'status': status,
    };

    if (id != null) {
      data['_id'] = id;
    }

    return data;
  }
}
```

## Implementation Timeline

1. **Week 1: Setup and Authentication**

   - Set up project repositories
   - Create database schemas
   - Implement authentication APIs
   - Develop login/registration screens

2. **Week 2: Core Features - Backend**

   - Implement user management
   - Develop strike assignment logic
   - Create pizza events tracking
   - Set up notification system

3. **Week 3: Core Features - Frontend**

   - Build dashboard screens
   - Develop strike management UI
   - Create user profile screens
   - Implement admin-specific features

4. **Week 4: Integration and Polish**

   - Connect frontend to backend
   - Implement state management
   - Add real-time updates
   - Polish UI/UX

5. **Week 5: Testing and Deployment**
   - Perform unit and integration testing
   - User acceptance testing
   - Deploy backend to cloud provider
   - Release mobile app

## Security Considerations

1. **Authentication**

   - JWT-based authentication with refresh tokens
   - Password hashing using bcrypt
   - HTTPS for all API requests

2. **Authorization**

   - Role-based access control
   - Special middleware for admin actions
   - Input validation on all endpoints

3. **Data Protection**
   - Sanitize all user inputs
   - Rate limiting on sensitive endpoints
   - Validation of cross-admin actions
