import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view/details/details_screen.dart';
import 'package:socer_project/utils/widget/navigate.dart';
import '../../../utils/end_points/urls.dart';
import '../../view_model/system_cubit.dart';

class NowPlayingScreen extends StatelessWidget {

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
          itemCount: cubit.nowPlayingModel?.results?.length,
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
                      .nowPlayingModel!.results![current]
                      .id as int);
                  cubit.getd(cubit
                      .nowPlayingModel!.results![current]
                      .id as int);
                  cubit.GetCast(cubit
                      .nowPlayingModel!.results![current]
                      .id as int);
                  cubit.getVideos(cubit
                      .nowPlayingModel!.results![current]
                      .id as int);

                  pushNavigate(context, DetailsScreen(
                      id:cubit.nowPlayingModel?.results![current] ,

                  ),);
                  print(cubit.nowPlayingModel?.results![current].id);
                  
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 180.w, height: 210.h,
                      child: Image.network('${EndPoints.linkImage}/${cubit.nowPlayingModel?.results?[current].posterPath}'),),
                    SizedBox(height: 10.h,),
                    Text('${cubit.nowPlayingModel?.results?[current].title}',
                      style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
        );
      },
    );
  }
}
