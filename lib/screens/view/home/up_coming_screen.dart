import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/end_points/urls.dart';
import '../../../utils/widget/navigate.dart';

import '../../view_model/system_cubit.dart';
import '../details/details_screen.dart';


class UpComingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=SystemCubit.get(context);
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cubit.upcomingMovieModel?.results?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              childAspectRatio: 0.63,
              crossAxisSpacing: 15),
          itemBuilder: (context, current) =>
              InkWell(
                onTap: ()
                {
                  cubit.GetReview(cubit
                      .upcomingMovieModel!.results![current]
                      .id as int);
                  cubit.GetCast(cubit
                      .upcomingMovieModel!.results![current]
                      .id as int);
                  cubit.getd(cubit
                      .upcomingMovieModel!.results![current]
                      .id as int);
                  cubit.getVideos(cubit
                      .upcomingMovieModel!.results![current]
                      .id as int);
                  pushNavigate(context, DetailsScreen(id:cubit.upcomingMovieModel?.results?[current] ));
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 180.w, height: 210.h,
                      child: Image.network('${EndPoints.linkImage}/${cubit.upcomingMovieModel?.results?[current].posterPath}'),),
                    SizedBox(height: 10.h,),
                    Text('${cubit.upcomingMovieModel?.results?[current].title}',
                      style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
        );
      },
    );
  }
}
