import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    bool? status,
    String? message,
    ProfileDataEntity? profileDataEntity,
  }) : super(
          status: status ?? false,
          message: message ?? '',
          profileDataEntity: profileDataEntity!,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json['status'],
        message: json['message'],
        profileDataEntity: ProfileDataModel.fromJson(json['profile']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'profile': profileDataEntity,
      };
}

class ProfileDataModel extends ProfileDataEntity {
  const ProfileDataModel({
    String? sId,
    String? userName,
    bool? isAdmin,
    String? noId,
  }) : super(
          sId: sId ?? '',
          userName: userName ?? '',
          noId: noId ?? '',
          isAdmin: isAdmin ?? false,
        );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        sId: json['_id'],
        userName: json['userName'],
        isAdmin: json['isAdmin'],
        noId: json['noId'],
      );

  Map<String, dynamic> toJson() => {
        'sId': sId,
        'userName': userName,
        'isAdmin': isAdmin,
        'noId': noId,
      };
}
