import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';

import '../../../../utils/end_points/urls.dart';
import '../../../../utils/widget/navigate.dart';
import '../../details/details_screen.dart';

class TrendingList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=SystemCubit.get(context);
        return SizedBox(
          height: 240.h,
          child: ListView.separated(
              physics:const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(width: 10.w,),
              itemCount: cubit.trendingMovieModel?.results?.length ?? 0,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.GetReview(cubit
                              .trendingMovieModel!.results![index]
                              .id as int);
                          cubit.getGenre(cubit
                              .trendingMovieModel!.results![index]
                              .id as int);
                          cubit.GetCast(cubit
                              .trendingMovieModel!.results![index]
                              .id as int);
                          cubit.getVideos(cubit
                              .trendingMovieModel!.results![index]
                              .id as int);
                          pushNavigate(context, DetailsScreen(
                            id: cubit.trendingMovieModel?.results?[index],));
                        },
                        child: SizedBox(
                          height: 240.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.network(
                                fit: BoxFit.cover,
                                height: 220.h,
                                width: 145.w,
                                '${EndPoints.linkImage}/${cubit.trendingMovieModel
                                    ?.results?[index].posterPath}'),
                          ),
                        ),
                      ),
                    ],
                  )
          ),
        );
      },
    );
  }
}
