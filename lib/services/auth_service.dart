class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userRoleKey = 'user_role';
  static const String _userIdKey = 'user_id';
  static const String _offlineDataKey = 'offline_data';

  // Offline Test Data
  static final Map<String, dynamic> _testData = {
    'owner': {
      'id': 'owner_001',
      'name': 'مالک سیستم',
      'phone': '09120000001',
      'role': 'owner',
      'email': 'owner@tahavol.com',
      'isVerified': true,
      'profileImage': null,
    },
    'drivers': [
      {
        'id': 'driver_test_001',
        'name': 'رضا کریمی',
        'phone': '09121234567',
        'role': 'driver',
        'rating': 4.8,
        'totalTrips': 45,
        'isVerified': true,
        'car': 'پژو ۴۰۵',
        'location': {'lat': 35.6892, 'lng': 51.3890},
      },
      {
        'id': 'driver_test_002',
        'name': 'علی محمدی',
        'phone': '09129876543',
        'role': 'driver',
        'rating': 4.5,
        'totalTrips': 32,
        'isVerified': true,
        'car': 'ایران خودرو ۱۱۱',
        'location': {'lat': 35.7694, 'lng': 51.4107},
      },
    ],
    'owners': [
      {
        'id': 'owner_test_001',
        'name': 'محمد احمدی',
        'phone': '09130000001',
        'role': 'owner',
        'company': 'شرکت تجارت پارسیان',
        'isVerified': true,
      },
    ],
    'loads': [
      {
        'id': 'load_001',
        'ownerId': 'owner_test_001',
        'origin': 'تهران - میدان انقلاب',
        'destination': 'اصفهان - خیابان فردوسی',
        'weight': 500.0,
        'volume': 2.5,
        'loadType': 'general',
        'price': 250000.0,
        'status': 'pending',
        'description': 'کالای عمومی - احتیاط با برخورد',
        'createdAt': '2026-08-26T10:00:00Z',
      },
      {
        'id': 'load_002',
        'ownerId': 'owner_test_001',
        'origin': 'تهران - میدان رسالت',
        'destination': 'قزوین - بلوار کشاورزی',
        'weight': 1000.0,
        'volume': 4.0,
        'loadType': 'fragile',
        'price': 350000.0,
        'status': 'accepted',
        'driverId': 'driver_test_001',
        'description': 'کالای شکستنی - احتیاط زیاد لازم',
        'createdAt': '2026-08-26T11:30:00Z',
      },
    ],
    'admins': [],
  };

  // Check if developer mode is enabled
  static bool isDeveloperModeEnabled() {
    // اینجا می‌تونید چک کنید که develop mode فعال هست یا نه
    // برای حالا, می‌گیریم از SharedPreferences
    return false; // اینو بعدا تغییر می‌دیم
  }

  // Login as Owner (Offline Mode)
  static Future<Map<String, dynamic>> loginAsOwner() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return {
        'success': true,
        'user': _testData['owner'],
        'token': 'offline_owner_token_${DateTime.now().millisecondsSinceEpoch}',
        'message': 'خوش آمدید، مالک محترم!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ورود به حالت آفلاین',
      };
    }
  }

  // Login as Admin (Offline Mode)
  static Future<Map<String, dynamic>> loginAsAdmin(
    String adminId,
    String password,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final List<dynamic> admins = _testData['admins'] ?? [];
      final admin = admins.firstWhere(
        (a) => a['id'] == adminId && a['password'] == password,
        orElse: () => null,
      );

      if (admin == null) {
        return {
          'success': false,
          'message': 'نام کاربری یا رمز عبور اشتباه است',
        };
      }

      return {
        'success': true,
        'user': admin,
        'token':
            'offline_admin_token_${DateTime.now().millisecondsSinceEpoch}',
        'message': 'خوش آمدید، ${admin['name']}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ورود',
      };
    }
  }

  // Test Driver Simulation
  static Future<Map<String, dynamic>> loginAsTestDriver() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final driver = _testData['drivers'][0];
      return {
        'success': true,
        'user': driver,
        'token': 'test_driver_token_${DateTime.now().millisecondsSinceEpoch}',
        'isTestMode': true,
        'message': 'وارد حالت تست راننده شدید',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ورود به حالت تست',
      };
    }
  }

  // Test Owner (Load) Simulation
  static Future<Map<String, dynamic>> loginAsTestOwner() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final owner = _testData['owners'][0];
      return {
        'success': true,
        'user': owner,
        'token': 'test_owner_token_${DateTime.now().millisecondsSinceEpoch}',
        'isTestMode': true,
        'message': 'وارد حالت تست صاحب بار شدید',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ورود به حالت تست',
      };
    }
  }

  // Get Test Data
  static Map<String, dynamic> getTestData() {
    return _testData;
  }

  // Add Admin
  static Future<Map<String, dynamic>> addAdmin({
    required String name,
    required String phone,
    required String password,
    required String permission,
  }) async {
    try {
      final newAdmin = {
        'id': 'admin_${DateTime.now().millisecondsSinceEpoch}',
        'name': name,
        'phone': phone,
        'password': password,
        'permission': permission,
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      };

      _testData['admins'].add(newAdmin);

      return {
        'success': true,
        'message': 'مدیر با موفقیت اضافه شد',
        'admin': newAdmin,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در اضافه کردن مدیر',
      };
    }
  }

  // Get All Admins
  static List<Map<String, dynamic>> getAllAdmins() {
    return List<Map<String, dynamic>>.from(_testData['admins'] ?? []);
  }

  // Delete Admin
  static Future<Map<String, dynamic>> deleteAdmin(String adminId) async {
    try {
      _testData['admins']
          .removeWhere((admin) => admin['id'] == adminId);
      return {
        'success': true,
        'message': 'مدیر حذف شد',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در حذف مدیر',
      };
    }
  }

  // Update Admin Status
  static Future<Map<String, dynamic>> updateAdminStatus(
    String adminId,
    bool isActive,
  ) async {
    try {
      final admin = _testData['admins']
          .firstWhere((a) => a['id'] == adminId, orElse: () => null);

      if (admin != null) {
        admin['isActive'] = isActive;
        return {
          'success': true,
          'message': isActive ? 'مدیر فعال شد' : 'مدیر غیرفعال شد',
        };
      }

      return {
        'success': false,
        'message': 'مدیر یافت نشد',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در به‌روزرسانی وضعیت',
      };
    }
  }

  // Check Admin Permission
  static bool checkAdminPermission(
    String permission,
    String requiredPermission,
  ) {
    const Map<String, List<String>> permissionMap = {
      'admin_full': [
        'view_dashboard',
        'manage_users',
        'verify_documents',
        'manage_loads',
        'send_announcements',
        'view_reports',
        'manage_admins',
        'manage_support',
      ],
      'admin_documents': [
        'view_dashboard',
        'verify_documents',
        'view_reports',
      ],
      'admin_users': [
        'view_dashboard',
        'manage_users',
        'view_reports',
      ],
      'admin_viewer': ['view_dashboard', 'view_reports'],
      'admin_support': ['view_dashboard', 'manage_support'],
    };

    final permissions = permissionMap[permission] ?? [];
    return permissions.contains(requiredPermission);
  }

  // Logout
  static Future<void> logout() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // اینجا می‌تونید داده‌ها رو پاک کنید
    } catch (e) {
      // Handle error
    }
  }
}
