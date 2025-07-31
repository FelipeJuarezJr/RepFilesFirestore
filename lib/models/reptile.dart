import 'package:cloud_firestore/cloud_firestore.dart';

class Reptile {
  final String? id;
  final String name;
  final String species;
  final String gender;
  final String? morph;
  final DateTime? birthDate;
  final DateTime? acquisitionDate;
  final String? breeder;
  final String? notes;
  final List<String> photoUrls;
  final String status; // active, breeding, sold, deceased
  final Map<String, dynamic> measurements;
  final DateTime? lastFeeding;
  final DateTime? lastHealthCheck;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reptile({
    this.id,
    required this.name,
    required this.species,
    required this.gender,
    this.morph,
    this.birthDate,
    this.acquisitionDate,
    this.breeder,
    this.notes,
    this.photoUrls = const [],
    this.status = 'active',
    this.measurements = const {},
    this.lastFeeding,
    this.lastHealthCheck,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'species': species,
      'gender': gender,
      'morph': morph,
      'birthDate': birthDate?.toIso8601String(),
      'acquisitionDate': acquisitionDate?.toIso8601String(),
      'breeder': breeder,
      'notes': notes,
      'photoUrls': photoUrls,
      'status': status,
      'measurements': measurements,
      'lastFeeding': lastFeeding?.toIso8601String(),
      'lastHealthCheck': lastHealthCheck?.toIso8601String(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create from Firestore document
  factory Reptile.fromMap(Map<String, dynamic> map, String id) {
    return Reptile(
      id: id,
      name: map['name'] ?? '',
      species: map['species'] ?? '',
      gender: map['gender'] ?? '',
      morph: map['morph'],
      birthDate: map['birthDate'] != null 
          ? DateTime.parse(map['birthDate']) 
          : null,
      acquisitionDate: map['acquisitionDate'] != null 
          ? DateTime.parse(map['acquisitionDate']) 
          : null,
      breeder: map['breeder'],
      notes: map['notes'],
      photoUrls: List<String>.from(map['photoUrls'] ?? []),
      status: map['status'] ?? 'active',
      measurements: Map<String, dynamic>.from(map['measurements'] ?? {}),
      lastFeeding: map['lastFeeding'] != null 
          ? DateTime.parse(map['lastFeeding']) 
          : null,
      lastHealthCheck: map['lastHealthCheck'] != null 
          ? DateTime.parse(map['lastHealthCheck']) 
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy with updated fields
  Reptile copyWith({
    String? id,
    String? name,
    String? species,
    String? gender,
    String? morph,
    DateTime? birthDate,
    DateTime? acquisitionDate,
    String? breeder,
    String? notes,
    List<String>? photoUrls,
    String? status,
    Map<String, dynamic>? measurements,
    DateTime? lastFeeding,
    DateTime? lastHealthCheck,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Reptile(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      morph: morph ?? this.morph,
      birthDate: birthDate ?? this.birthDate,
      acquisitionDate: acquisitionDate ?? this.acquisitionDate,
      breeder: breeder ?? this.breeder,
      notes: notes ?? this.notes,
      photoUrls: photoUrls ?? this.photoUrls,
      status: status ?? this.status,
      measurements: measurements ?? this.measurements,
      lastFeeding: lastFeeding ?? this.lastFeeding,
      lastHealthCheck: lastHealthCheck ?? this.lastHealthCheck,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Get display name
  String get displayName => name.isNotEmpty ? name : 'Unnamed $species';

  // Get age
  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    return now.year - birthDate!.year - 
           (now.month < birthDate!.month || 
            (now.month == birthDate!.month && now.day < birthDate!.day) ? 1 : 0);
  }

  // Get status color
  String get statusColor {
    switch (status) {
      case 'active':
        return 'success';
      case 'breeding':
        return 'info';
      case 'sold':
        return 'warning';
      case 'deceased':
        return 'danger';
      default:
        return 'secondary';
    }
  }
} 