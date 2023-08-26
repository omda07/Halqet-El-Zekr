import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    bool? status,
    String? message,
  }) : super(
          status: status ?? false,
          message: message ?? '',
        );

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        status: json['status'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
