import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';

import '../../../../generated/l10n.dart';
import '../../../view_model/movie_cubit/system_state.dart';

class DetailsTabs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state) {
        var cubit =SystemCubit.get(context);
        List<String> detailsTaps = [
          S.of(context).detailsTab1,
          S.of(context).detailsTab2,
          S.of(context).detailsTab3,
        ];
        return SizedBox(
          height: 40.h,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0.w),
            child: ListView.separated(
              itemCount: detailsTaps.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w,),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  InkWell(
                    onTap: () {
                      cubit.ChangeIndex(index);
                    },
                    child: Column(
                      children: [
                        Center(child: Text(detailsTaps[index],
                          style: TextStyle(color:  cubit.dark? Colors.white:Colors.black, height: 2.h),)),

                        cubit.index == index ?
                        Container(
                            width: 95.w,
                            height: 4.h,
                            color: Colors.blueGrey
                        ) :
                        Container(
                          width: 95.w,
                          height: 4.h,
                        ),

                      ],
                    ),
                  ),


            ),
          ),
        );
      },
    );
  }
}
