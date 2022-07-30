import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/cubit/home/home_cubit.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/view/screens/tasbih/selected_tasbih_screen.dart';

import '../../resources/color_manager.dart';
import '../../widgets/app_bar/app_bar_custom.dart';
import '../../widgets/text_custom/text_custom.dart';



class TasbehScreen extends StatelessWidget {
  const TasbehScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarCustom(
        context: context,
        leading: 'التسبيح',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..getTasbeh(context: context),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.tasbehModel != null,
              builder: (context) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedTasbehScreen(
                                    i: index,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              offset: const Offset(0.6, 1.2), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.primary,
                                  width: 2,
                                ),
                              ),
                              child: FittedBox(
                                child: textCustom(context:context,text:
                                  '${cubit.tasbehModel!.tasbeh![index].reference}',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: textCustom(context:context,text:
                                '${cubit.tasbehModel!.tasbeh![index].content}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                fontSize: 18.sp

                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textCustom(context:context,text:
                                  '${(cubit.tasbehModel!.tasbeh![index].count) }',
                                  fontWeight: FontWeight.bold,
                                ),
                                 textCustom(context:context,text:
                                  'counts',
                                  fontSize: 12.sp
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: cubit.tasbehModel!.tasbeh!.length,
                );
              },
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
