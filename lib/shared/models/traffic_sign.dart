enum SignType { regulatory, warning, informational }

enum SignStatus { pending, approved, rejected }

class TrafficSign {
  final String id;
  final SignType type;
  final String label;
  final double longitude;
  final double latitude;
  final String? imageUrl;
  final SignStatus status;
  final String? submittedById;
  final DateTime createdAt;

  TrafficSign({
    required this.id,
    required this.type,
    required this.label,
    required this.longitude,
    required this.latitude,
    this.imageUrl,
    required this.status,
    this.submittedById,
    required this.createdAt,
  });

  factory TrafficSign.fromJson(Map<String, dynamic> json) {
    return TrafficSign(
      id: json['id'] as String,
      type: _parseSignType(json['type'] as String),
      label: json['label'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      status: _parseSignStatus(json['status'] as String),
      submittedById: json['submittedBy']?['id'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'label': label,
      'longitude': longitude,
      'latitude': latitude,
      'imageUrl': imageUrl,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static SignType _parseSignType(String type) {
    switch (type.toLowerCase()) {
      case 'regulatory':
        return SignType.regulatory;
      case 'warning':
        return SignType.warning;
      case 'informational':
        return SignType.informational;
      default:
        return SignType.informational;
    }
  }

  static SignStatus _parseSignStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return SignStatus.pending;
      case 'approved':
        return SignStatus.approved;
      case 'rejected':
        return SignStatus.rejected;
      default:
        return SignStatus.pending;
    }
  }

  String get typeLabel {
    switch (type) {
      case SignType.regulatory:
        return 'Regulatory';
      case SignType.warning:
        return 'Warning';
      case SignType.informational:
        return 'Informational';
    }
  }

  String get typeEmoji {
    switch (type) {
      case SignType.regulatory:
        return '🛑';
      case SignType.warning:
        return '⚠️';
      case SignType.informational:
        return 'ℹ️';
    }
  }
}
