import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';
import 'package:lottie/lottie.dart';

import '../../cubit/cubit For Internet/internet_cubit.dart';
import '../../cubit/cubit For Internet/internet_states.dart';
import 'elevated_button/elevated_button_custom.dart';


// screen appears when the internet is cut off
Widget noInternet(context) => BlocConsumer<InternetCubit, InternetStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/no internet.json',
                  width: MediaQuery.of(context).size.width / 1, height: 400),
              textCustom(context:context,
                  text: 'تأكد من موجود انترنت',
                  textAlign: TextAlign.center,
                  fontSize: 22.sp),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 160,
                child: ElevatedButtonCustom(
                    text: 'أعد المحاولة',
                    onPressed: () {
                      InternetCubit.get(context).checkInternetConnection();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
