import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';

import '../../../../utils/end_points/urls.dart';
import '../../../../utils/widget/navigate.dart';
import '../../../view_model/movie_cubit/system_state.dart';
import '../../details/details_screen.dart';


class TopRatedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=SystemCubit.get(context);
        return GridView.builder(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cubit.topRatedMovieModel?.results?.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              childAspectRatio: 0.62,
              crossAxisSpacing: 15),
          itemBuilder: (context, current) =>
              InkWell(
                onTap: ()
                {
                  cubit.GetReview(cubit
                      .topRatedMovieModel!.results![current]
                      .id as int);
                  cubit.getGenre(cubit
                      .topRatedMovieModel!.results![current]
                      .id as int);
                  cubit.GetCast(cubit
                      .topRatedMovieModel!.results![current]
                      .id as int);
                  cubit.getVideos(cubit
                      .topRatedMovieModel!.results![current]
                      .id as int);
                  pushNavigate(context, DetailsScreen(id:cubit.topRatedMovieModel?.results?[current]  ));
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 180.w, height: 208.h,
                      child: Image.network('${EndPoints.linkImage}/${cubit.topRatedMovieModel?.results?[current].posterPath}'),),
                    SizedBox(height: 10.h,),
                    Text('${cubit.topRatedMovieModel?.results?[current].title}',
                      style: TextStyle(color:  cubit.dark? Colors.white:Colors.black),),
                  ],
                ),
              ),
        );
      },
    );
  }
}
