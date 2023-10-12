import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/end_points/urls.dart';
import '../../../utils/widget/navigate.dart';
import '../../view_model/system_cubit.dart';
import '../details/details_screen.dart';


class PopularScreen extends StatelessWidget {

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
          itemCount: cubit.popularMovieModel?.results?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    cubit.getd(cubit
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
                      width: 180.w, height: 210.h,
                      child: Image.network('${EndPoints.linkImage}/${cubit.popularMovieModel?.results?[current].posterPath}'),),
                    SizedBox(height: 10.h,),
                    Text('${cubit.popularMovieModel?.results?[current].title}',
                      style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
        );
      },
    );
  }
}
