class MapsService {
  // Neshan API Key
  static const String neshanApiKey = 'YOUR_NESHAN_API_KEY';

  // Default Map Center (Tehran)
  static const double defaultLat = 35.6892;
  static const double defaultLng = 51.3890;
  static const double defaultZoom = 15.0;

  // Calculate distance between two points using Haversine formula
  static double calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const double radius = 6371; // Earth radius in km
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLng = _degreesToRadians(lng2 - lng1);

    final double a = _sin2(dLat / 2) +
        _cos(lat1 * 3.14159 / 180) *
            _cos(lat2 * 3.14159 / 180) *
            _sin2(dLng / 2);

    final double c = 2 * _atan2(_sqrt(a), _sqrt(1 - a));

    return radius * c;
  }

  // Calculate estimated time (simple formula)
  static Duration estimateTime(double distanceKm) {
    // فرض: ۶۰ کیلومتر در ساعت
    final double hours = distanceKm / 60;
    final int minutes = (hours * 60).toInt();
    return Duration(minutes: minutes);
  }

  // Get nearby loads/drivers
  static Future<List<Map<String, dynamic>>> getNearbyItems(
    double userLat,
    double userLng,
    double radiusKm,
    List<Map<String, dynamic>> items,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      return items.where((item) {
        double itemLat = item['location']?['lat'] ?? 0;
        double itemLng = item['location']?['lng'] ?? 0;

        double distance = calculateDistance(
          userLat,
          userLng,
          itemLat,
          itemLng,
        );

        return distance <= radiusKm;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // Get route between two points
  static Future<Map<String, dynamic>> getRoute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final double distance = calculateDistance(
        startLat,
        startLng,
        endLat,
        endLng,
      );

      final Duration estimatedTime = estimateTime(distance);

      return {
        'success': true,
        'distance': distance,
        'estimatedTime': estimatedTime,
        'startLat': startLat,
        'startLng': startLng,
        'endLat': endLat,
        'endLng': endLng,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در دریافت مسیر',
      };
    }
  }

  // Get address from coordinates
  static Future<String> getAddressFromCoordinates(
    double lat,
    double lng,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // این فقط شبیه‌سازی است
      return 'تهران - خیابان فردوسی (${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)})';
    } catch (e) {
      return 'نامشخص';
    }
  }

  // Get coordinates from address
  static Future<Map<String, double>> getCoordinatesFromAddress(
    String address,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // شبیه‌سازی - در واقعیت باید از API استفاده کنید
      return {
        'lat': defaultLat + (address.length % 10) * 0.01,
        'lng': defaultLng + (address.length % 10) * 0.01,
      };
    } catch (e) {
      return {'lat': defaultLat, 'lng': defaultLng};
    }
  }

  // Helper functions
  static double _degreesToRadians(double degrees) {
    return degrees * 3.14159 / 180;
  }

  static double _sin2(double x) {
    final double sinX = _sin(x);
    return sinX * sinX;
  }

  static double _sin(double x) {
    // تقریب ساده sin
    return x - (x * x * x) / 6 + (x * x * x * x * x) / 120;
  }

  static double _cos(double x) {
    // تقریب ساده cos
    return 1 - (x * x) / 2 + (x * x * x * x) / 24;
  }

  static double _sqrt(double x) {
    if (x < 0) return 0;
    if (x == 0) return 0;
    double result = x;
    for (int i = 0; i < 10; i++) {
      result = (result + x / result) / 2;
    }
    return result;
  }

  static double _atan2(double y, double x) {
    if (x > 0) {
      return _atan(y / x);
    } else if (x < 0 && y >= 0) {
      return _atan(y / x) + 3.14159;
    } else if (x < 0 && y < 0) {
      return _atan(y / x) - 3.14159;
    } else if (x == 0 && y > 0) {
      return 3.14159 / 2;
    } else if (x == 0 && y < 0) {
      return -3.14159 / 2;
    }
    return 0;
  }

  static double _atan(double x) {
    return x - (x * x * x) / 3 + (x * x * x * x * x) / 5;
  }
}
