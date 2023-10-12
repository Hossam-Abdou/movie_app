import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socer_project/screens/view/details/videos.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/utils/end_points/urls.dart';
import 'package:socer_project/utils/widget/navigate.dart';
import 'component/cast_screen.dart';
import 'component/details_tab.dart';
import 'component/reviews_screen.dart';

class DetailsScreen extends StatelessWidget {
  dynamic id;

  DetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=SystemCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_sharp)),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 260.h,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight:Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r)
                      ),
                      child: Image.network(
                        '${EndPoints.linkImage}/${id!.backdropPath}',
                        fit: BoxFit.cover,
                        height: 180.h,
                        width:double.infinity,
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      bottom: 90.h,
                      child: Row(
                        children: [
                          Icon(Icons.star_border,color: Colors.deepOrange,),
                          Text('${id!.voteAverage}',style: GoogleFonts.poppins(color: Colors.deepOrange,fontSize: 18.sp,fontWeight: FontWeight.w300),)
                        ],
                      ),
                    ),
                    Positioned(
                        top: 130.h,
                      left: 29.w,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.network(
                              '${EndPoints.linkImage}/${id!.posterPath}',
                              height: 130.h,
                              width:95.w,
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 50.0.h),
                                child: SizedBox(
                                    width: 180.w,
                                    child: Text('${id!.title}',style: GoogleFonts.poppins(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w300),)),
                              ),
                              TextButton(
                                  onPressed: ()
                                   {
                                    // launch('https://www.youtube.com/watch?v=${id.id}');

                                     pushNavigate(context, VideosScreen(id:id));

                                  },
                                  child: const Text('Watch Now'),)
                            ],
                          )

                        ],
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.calendar_today),
                  Text('${id!.releaseDate}'),
                  SizedBox(
                      height: 20.h,
                      child: VerticalDivider(width: 2,color: Colors.blueGrey,)),
                  Icon(Icons.language),
                  Text('${id!.originalLanguage}'),
                  SizedBox(
                      height: 20.h,

                      child: VerticalDivider(width: 2,color: Colors.blueGrey)),

                  Icon(Icons.airplane_ticket_rounded),
                  SizedBox(
                    width: 90.h,
                    child: Text('${cubit.modell?.genres?.map((genre) => genre.name).join(", ")}'),
                  )
                ],
              ),
              SizedBox(height: 25.h,),
              DetailsTabs(),
             cubit.index==0? Padding(
                padding:  EdgeInsets.symmetric(horizontal: 29.0.w),
                child: Text('${id!.overview}',style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w300,color: Colors.white),),
              ):
             cubit.index==1?
             cubit.reviewModel!.results!.isEmpty?const Center(child:  Text('There are No Reviews Yet',style: TextStyle(color: Colors.white),),
             ):
             ReviewsScreen():
             CastScreen()
            ],
          ),
        );
      },
    );
  }
}
