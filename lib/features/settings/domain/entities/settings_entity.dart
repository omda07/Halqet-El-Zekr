import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final bool status;
  final String message;

  const SettingsEntity({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
