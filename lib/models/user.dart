import 'package:intl/intl.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role; // 'driver', 'owner', 'admin'
  final String? profileImage;
  final String? nationalId;
  final String? drivingLicense;
  final String? vehicleInfo;
  final double? rating;
  final int? totalTrips;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final Map<String, dynamic>? location; // {lat, lng}
  final String? bankAccountNumber;
  final String? companyName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.nationalId,
    this.drivingLicense,
    this.vehicleInfo,
    this.rating,
    this.totalTrips,
    this.isVerified = false,
    this.isActive = true,
    required this.createdAt,
    this.lastLogin,
    this.location,
    this.bankAccountNumber,
    this.companyName,
  });

  String get fullName => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'driver',
      profileImage: json['profileImage'],
      nationalId: json['nationalId'],
      drivingLicense: json['drivingLicense'],
      vehicleInfo: json['vehicleInfo'],
      rating: (json['rating'] as num?)?.toDouble(),
      totalTrips: json['totalTrips'],
      isVerified: json['isVerified'] ?? false,
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      location: json['location'] as Map<String, dynamic>?,
      bankAccountNumber: json['bankAccountNumber'],
      companyName: json['companyName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'nationalId': nationalId,
      'drivingLicense': drivingLicense,
      'vehicleInfo': vehicleInfo,
      'rating': rating,
      'totalTrips': totalTrips,
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'location': location,
      'bankAccountNumber': bankAccountNumber,
      'companyName': companyName,
    };
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? profileImage,
    String? nationalId,
    String? drivingLicense,
    String? vehicleInfo,
    double? rating,
    int? totalTrips,
    bool? isVerified,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
    Map<String, dynamic>? location,
    String? bankAccountNumber,
    String? companyName,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      nationalId: nationalId ?? this.nationalId,
      drivingLicense: drivingLicense ?? this.drivingLicense,
      vehicleInfo: vehicleInfo ?? this.vehicleInfo,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      location: location ?? this.location,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      companyName: companyName ?? this.companyName,
    );
  }
}
