
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/usecases/profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase profileUsecase;

  ProfileCubit({required this.profileUsecase}) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);





  formatDate({required String format, required String dateTime}) {
    var date = DateFormat(format);
    var formatDate = date.format(DateTime.parse(dateTime));
    return formatDate;
  }
}
