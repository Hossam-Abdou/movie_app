import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/end_points/urls.dart';
import '../../../view_model/movie_cubit/system_state.dart';

class CastScreen extends StatelessWidget {
  const CastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return SizedBox(
          height: 260.h,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: cubit.castModel?.cast?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                childAspectRatio: 0.63,
                crossAxisSpacing: 15),
            itemBuilder: (context, current) => Padding(
              padding: EdgeInsets.all(15.0.r),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage:
                        cubit.castModel?.cast![current].profilePath != null
                            ? NetworkImage(
                                '${EndPoints.linkImage}/${cubit.castModel?.cast?[current].profilePath}',
                              )
                            : const NetworkImage(
                                'https://img.freepik.com/premium-vector/3d-icon-user-profile-convex-volume-shape-person-circle_348818-1116.jpg',
                              ),
                  ),
                  Text(
                    '${cubit.castModel?.cast?[current].originalName}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                      color: cubit.dark ? Colors.white : Colors.black,
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    S.of(context).charName,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${cubit.castModel?.cast?[current].character}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cubit.dark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
