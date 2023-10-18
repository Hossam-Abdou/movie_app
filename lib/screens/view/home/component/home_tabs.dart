import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';

import '../../../../generated/l10n.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        List<String> taps = [
          S.of(context).homeTab1,
          S.of(context).homeTab2,
          S.of(context).homeTab3,
          S.of(context).homeTab4
        ];
        return SizedBox(
          height: 40.h,
          width: double.infinity,
          child: ListView.separated(
            itemCount: taps.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 10.w,
            ),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                cubit.changeIndex(index);
              },
              child: Column(
                children: [
                  Center(
                    child: Text(
                      taps[index],
                      style: TextStyle(
                        color: cubit.dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  cubit.index == index
                      ? Container(
                          width: 95.w,
                          height: 4.h,
                          color: const Color(0xFF3A3F47),
                        )
                      : SizedBox(
                          width: 95.w,
                          height: 4.h,
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
