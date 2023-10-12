import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';

class DetailsTabs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state) {
        var cubit =SystemCubit.get(context);
        return SizedBox(
          height: 40.h,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0.w),
            child: ListView.separated(
              itemCount: cubit.detailsTaps.length,
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
                        Center(child: Text(cubit.detailsTaps[index],
                          style: TextStyle(color: Colors.white, height: 2.h),)),

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
