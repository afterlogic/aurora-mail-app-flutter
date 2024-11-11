import 'package:equatable/equatable.dart';

import 'InviteStatus.dart';

class Attendee extends Equatable {
  final int access;
  final String email;
  final String name;
  final InviteStatus status;

  const Attendee({
    required this.access,
    required this.email,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'access': this.access,
      'email': this.email,
      'name': this.name,
      'status': this.status.statusCode,
    };
  }

  factory Attendee.fromMap(Map<String, dynamic> map) {
    return Attendee(
      access: map['access'] as int,
      email: (map['email'] as String?)!,
      name: (map['name'] as String?) ?? '',
      status: InviteStatusMapper.fromCode(map['status'] as int),
    );
  }

  @override
  List<Object?> get props => [access, email, name, status];
}
