import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final bool status;
  final String message;
  final ProfileDataEntity profileDataEntity;

  const ProfileEntity({
    required this.status,
    required this.message,
    required this.profileDataEntity,
  });

  @override
  List<Object> get props => [status, message, profileDataEntity];
}

class ProfileDataEntity extends Equatable {
  final String sId;
  final String userName;
  final bool? isAdmin;
  final String noId;

  const ProfileDataEntity({
    required this.sId,
    required this.userName,
    required this.isAdmin,
    required this.noId,
  });

  @override
  List<Object?> get props => [
        sId,
        userName,
        isAdmin,
        noId,
      ];
}
