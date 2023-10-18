import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/end_points/urls.dart';
import '../../../../utils/widget/navigate.dart';
import '../../../view_model/movie_cubit/system_cubit.dart';
import '../../../view_model/movie_cubit/system_state.dart';
import '../../details/details_screen.dart';


class PopularScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state)
      {
        var cubit=SystemCubit.get(context);
        return GridView.builder(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cubit.popularMovieModel?.results?.length,
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
                      .popularMovieModel!.results![current]
                      .id as int);
                  cubit.getGenre(cubit
                      .popularMovieModel!.results![current]
                      .id as int);
                  cubit.GetCast(cubit
                      .popularMovieModel!.results![current]
                      .id as int);
                  cubit.getVideos(cubit
                      .popularMovieModel!.results![current]
                      .id as int);
                  pushNavigate(context, DetailsScreen(id:cubit.popularMovieModel?.results![current]  ));
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 180.w, height: 205.h,
                      child: Image.network('${EndPoints.linkImage}/${cubit.popularMovieModel?.results?[current].posterPath}'),),
                    SizedBox(height: 10.h,),
                    Text('${cubit.popularMovieModel?.results?[current].title}',
                      style: TextStyle(color:  cubit.dark? Colors.white:Colors.black),),
                  ],
                ),
              ),
        );
      }
    );
  }
}
