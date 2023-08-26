import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class JuzParams extends Equatable {
  final String juzId;

  const JuzParams({required this.juzId});

  @override
  List<Object?> get props => [juzId];
}

class YasserQuranParams extends Equatable {
  final int reciterNum;

  const YasserQuranParams({required this.reciterNum});

  @override
  List<Object?> get props => [reciterNum];
}

class AudiosParams extends Equatable {
  final String reciterId;

  const AudiosParams({required this.reciterId});

  @override
  List<Object?> get props => [];
}

class CreateRoomParams extends Equatable {
  final String name;

  const CreateRoomParams({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}

class CreateNoIdParams extends Equatable {
  final String noId;

  const CreateNoIdParams({
    required this.noId,
  });

  @override
  List<Object?> get props => [noId];
}

class UploadImageRoomParams extends Equatable {
  final String name;
  final String path;
  final String roomId;

  const UploadImageRoomParams({
    required this.name,
    required this.path,
    required this.roomId,
  });

  @override
  List<Object?> get props => [name];
}

class UpdateUserRoomParams extends Equatable {
  final String id;

  const UpdateUserRoomParams({
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}

class CreateKhatmaParams extends Equatable {
  final String name;
  final String roomId;

  const CreateKhatmaParams({
    required this.name,
    required this.roomId,
  });

  @override
  List<Object?> get props => [name, roomId];
}

class RoomDataParams extends Equatable {
  final String roomId;

  const RoomDataParams({
    required this.roomId,
  });

  @override
  List<Object?> get props => [roomId];
}

class KhatmaParams extends Equatable {
  final String khatmaId;

  const KhatmaParams({
    required this.khatmaId,
  });

  @override
  List<Object?> get props => [khatmaId];
}

class UpdateJuzParams extends Equatable {
  final String juzId;
  final String khatmaId;
  final String checkDone;

  const UpdateJuzParams({
    required this.juzId,
    required this.khatmaId,
    required this.checkDone,
  });

  @override
  List<Object?> get props => [khatmaId, juzId, checkDone];
}

class LoginParams extends Equatable {
  final String userName;
  final String password;

  const LoginParams({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [userName, password];
}

class RegisterParams extends Equatable {
  final String userName;
  final String password;

  const RegisterParams({required this.userName, required this.password});

  @override
  List<Object> get props => [
        password,
      ];
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class HadeethDetailsParams extends Equatable {
  final String categoryId;
  final String page;

  const HadeethDetailsParams({
    required this.categoryId,
    required this.page,
  });

  @override
  List<Object> get props => [categoryId, page];
}

class HadeethInfoParams extends Equatable {
  final String hadeethId;

  const HadeethInfoParams({
    required this.hadeethId,
  });

  @override
  List<Object> get props => [hadeethId];
}

class SurahParams extends Equatable {
  final String surahId;

  const SurahParams({
    required this.surahId,
  });

  @override
  List<Object> get props => [surahId];
}

class AudioParams extends Equatable {
  final String surahId;

  const AudioParams({
    required this.surahId,
  });

  @override
  List<Object> get props => [surahId];
}

class CreateNameParams extends Equatable {
  final String name;
  final String uId;

  const CreateNameParams({
    required this.name,
    required this.uId,
  });

  @override
  List<Object> get props => [uId];
}

class EditProfileParams extends Equatable {
  final String? userName;
  final String? department;
  final String? noId;

  const EditProfileParams({
    this.userName,
    this.department,
    this.noId,
  });

  @override
  List<Object> get props => [userName!, department!, noId!];
}
