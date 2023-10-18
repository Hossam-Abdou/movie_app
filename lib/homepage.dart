import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';

import 'utils/colors/custom_colors.dart';

class HomeNavPage extends StatelessWidget {
  const HomeNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Directionality(
          textDirection: cubit.currentLanguage == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: CustomColors.primaryButton,
              items: cubit.items,
              index: cubit.currentIndex,
              height: 50.h,
              onTap: (currentIndex) => cubit.changeCurrentIndex(
                currentIndex,
              ),
            ),
            body: cubit.layouts[cubit.currentIndex],
          ),
        );
      },
    );
  }
}
