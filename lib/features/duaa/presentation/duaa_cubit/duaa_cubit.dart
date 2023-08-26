import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';
import '../../data/models/duaaModel.dart';
import 'duaa_state.dart';

import 'package:share_plus/share_plus.dart';

class DuaaCubit extends Cubit<DuaaStates> {
  DuaaCubit() : super(InitialHomeState());

  static DuaaCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  void changeNav(int index) {
    selectedIndex = index;
    emit(BottomNavBar());
  }

  Future<void> share(String text, String title, String link,
      {bool isText = true}) async {
    isText
        ? await Share.share(
            text,
            subject: title,
          )
        : await FlutterShare.share(
            title: text,
            text: title,
            linkUrl: link,
            chooserTitle: AppStrings.appName);
    emit(ShareSuccess());
  }

  String? azkarName;
  AzkarByCategory azkarByCategory = AzkarByCategory();
}
