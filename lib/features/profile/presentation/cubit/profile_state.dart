import 'package:equatable/equatable.dart';

import '../../domain/entities/profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class LogoutState extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileSuccess extends ProfileState {
  final ProfileEntity profileEntity;

  const GetProfileSuccess({required this.profileEntity});

  @override
  List<Object> get props => [];
}

class GetProfilesError extends ProfileState {
  final String message;

  const GetProfilesError({required this.message});

  @override
  List<Object> get props => [];
}
