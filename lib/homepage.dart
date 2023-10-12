import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';

import 'utils/colors/custom_colors.dart';

class HomeNavPage extends StatelessWidget {
  const HomeNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Scaffold(
          
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: CustomColors.primaryButton,
              items: cubit.items,
              index: cubit.currentindex,
              height: 50.h,
              onTap: (currentindex) => cubit.changecurrentindex(currentindex),
            ),
            body: cubit.layouts[cubit.currentindex]);
      },
    );
  }
}