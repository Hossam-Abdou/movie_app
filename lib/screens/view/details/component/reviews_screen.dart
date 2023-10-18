import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';

import '../../../../utils/end_points/urls.dart';
import '../../../view_model/movie_cubit/system_state.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return SizedBox(
          height: 250.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
            ),
            shrinkWrap: true,
            itemCount: cubit.reviewModel?.results?.length ?? 0,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: cubit.reviewModel?.results?[index]
                                    .authorDetails?.avatarPath !=
                                null
                            ? NetworkImage(
                                '${EndPoints.linkImage}/${cubit.reviewModel?.results?[index].authorDetails?.avatarPath}',
                              )
                            : const NetworkImage(
                                'https://img.freepik.com/premium-vector/3d-icon-user-profile-convex-volume-shape-person-circle_348818-1116.jpg',
                              ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        '${cubit.reviewModel?.results?[index].authorDetails?.username}',
                        style: TextStyle(
                          color: cubit.dark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Row(
                        children: [
                          Text(
                            '${cubit.reviewModel?.results?[index].authorDetails?.rating ?? 'No rates'}',
                            style: TextStyle(
                              color: cubit.dark ? Colors.white : Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.star_border_outlined,
                            color: cubit.dark ? Colors.white : Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    width: 270.w,
                    child: Text(
                      '${cubit.reviewModel?.results?[index].content}',
                      style: TextStyle(
                        color: cubit.dark ? Colors.white : Colors.black,
                      ),
                    ),
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
