import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view/details/details_screen.dart';
import 'package:socer_project/screens/view/home/now_playing_screen.dart';
import 'package:socer_project/screens/view/home/popular_screen.dart';
import 'package:socer_project/screens/view/home/up_coming_screen.dart';
import 'package:socer_project/screens/view/home/top_rated_screen.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/utils/end_points/urls.dart';
import 'package:socer_project/utils/widget/navigate.dart';
import '../../../../utils/colors/custom_colors.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            actions: [
              IconButton(onPressed: ()

              {
                cubit.changeMode();
              },
                  icon: const Icon(Icons.brightness_4_sharp),)
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(top: 8.0.h),
              child: Column(
                children: [
                  // ConditionalBuilder(
                  //   condition: cubit.trendingMovieModel == null,
                  //   fallback: (context) => CarouselSlider(
                  //       items: cubit.trendingMovieModel?.results
                  //           ?.map((e) => Row(
                  //             children: [
                  //               Image(
                  //         image: NetworkImage('${EndPoints.linkImage}/${e.posterPath}',),width: 100.w,height: 100,
                  //       ),
                  //             ],
                  //           ))
                  //           .toList()??[],
                  //       options: CarouselOptions(
                  //         height: 160.0.h,
                  //         viewportFraction: 1.0,
                  //         enableInfiniteScroll: true,
                  //         reverse: false,
                  //
                  //         initialPage: 0,
                  //         enlargeCenterPage: true,
                  //         autoPlay: true,
                  //         autoPlayCurve: accelerateEasing,
                  //         scrollDirection: Axis.horizontal,
                  //       )),
                  //   builder: (context) => Center(child: CircularProgressIndicator()),
                  // ),
                  cubit.trendingMovieModel==null?
                  CircularProgressIndicator(color: Colors.blue,):
                  SizedBox(
                    height: 240.h,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                      itemCount:cubit.trendingMovieModel?.results?.length??0,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          Column(
                            children: [
                              InkWell(
                                onTap: ()
                                {
                                  cubit.GetReview(cubit
                                      .trendingMovieModel!.results![index]
                                      .id as int);
                                  cubit.getd(cubit
                                      .trendingMovieModel!.results![index]
                                      .id as int);
                                  cubit.GetCast(cubit
                                      .trendingMovieModel!.results![index]
                                      .id as int);
                                  cubit.getVideos(cubit
                                      .trendingMovieModel!.results![index]
                                      .id as int);
                                  pushNavigate(context, DetailsScreen(id: cubit.trendingMovieModel?.results?[index],));
                                },
                                child: SizedBox(
                                  height: 240.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25 .r),
                                    child: Image.network(
                                        fit: BoxFit.cover,
                                        height: 220.h,
                                        width: 145.w,
                                        '${EndPoints.linkImage}/${cubit.trendingMovieModel?.results?[index].posterPath}'),
                                ),
                                ),
                              ),
                            ],
                          )
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: cubit.taps.length,
                      separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:(context, index) => InkWell(
                        onTap: ()
                          {
                            cubit.ChangeIndex(index);

                          },
                          child: Column(
                            children: [
                              Center(child: Text(cubit.taps[index],style: const TextStyle(color: Colors.white),)),
                        SizedBox(height: 5.h,),
                        cubit.index==index?
                        Container(
                          width: 95.w,
                          height: 4.h,
                          color:const  Color(0xFF3A3F47),
                        ) :
                        SizedBox(
                          width: 95.w,
                          height: 4.h,
                        )
                            ],
                          ),),


                    ),
                  ),
                  Expanded(
                    child: cubit.index==0 ? NowPlayingScreen():
                    cubit.index==1?UpComingScreen():
                    cubit.index==2?TopRatedScreen():
                    PopularScreen()
                  )


                ],
              ),
            ),
          )
        );
      },
    );;
  }
}
