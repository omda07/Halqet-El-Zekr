import 'package:flutter_bloc/flutter_bloc.dart';
import 'zakat_state.dart';

class ZakatCubit extends Cubit<ZakatStates> {
  ZakatCubit() : super(InitialHomeState());

  static ZakatCubit get(context) => BlocProvider.of(context);

  List<String> title = ['الشرط الأول:', 'الشرط الثانى:', 'الشرط الثالث:'];
  List<String> subTitle = [
    'بلوغ النصاب: أن يكون المبلغ كامل النصاب (85 جرام ذهب عيار 21) سعر الجرام بسعر اليوم، أى نقوم بضرب عدد الجرامات فى سعر الجرام الواحد فى يوم إخراج الزكاة، ويتم حساب الزكاة 2.5% من الأصل',
    'حولان الحول: عام هجرى كامل على النصاب',
    'أن تكون خاليا من الديون وفائض عن الحاجة أى يكون المال مدخر. كما أن حلى المرأة الذى تستخدمه للزينة ليس عليه زكاة، لأنها تتزين به، طالما أن النية منه الزينة، أما إذا كان الغرض منه الإدخار فعليها الزكاة، لكنها قد تخرج عليه صدقة من باب الورع.'
  ];

  double moneyResult = 0.0;
  double goldResult = 0.0;
  bool checkZakat = false;
  calculateZakat({required double money, required double gold}) {
    goldResult = (gold * 85) * (2.5 / 100);
    moneyResult = money * (2.5 / 100);
    if (goldResult <= moneyResult) {
      checkZakat = true;
    } else {
      moneyResult = 0.0;
      goldResult = 0.0;
      checkZakat = false;
    }
    emit(Calculation());
  }
}
