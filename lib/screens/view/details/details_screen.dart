import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socer_project/screens/view/details/videos.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';
import 'package:socer_project/utils/end_points/urls.dart';
import 'package:socer_project/utils/widget/navigate.dart';

class DetailsScreen extends StatelessWidget {
  dynamic id;

  DetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=SystemCubit.get(context);
        return Scaffold(
          backgroundColor: CustomColors.primaryButton,
          appBar: AppBar(
            title: const Text('Details'),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: CustomColors.primaryButton,
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
                  Icon(Icons.calendar_today,color: Colors.white54,),
                  Text('${id!.releaseDate}',style: GoogleFonts.roboto(color: Colors.white),),
                  SizedBox(
                      height: 20.h,
                      child: VerticalDivider(width: 2,color: Colors.blueGrey,)),
                  Icon(Icons.language,color: Colors.white54,),
                  Text('${id!.originalLanguage}',style: GoogleFonts.roboto(color: Colors.white),),
                  SizedBox(
                      height: 20.h,

                      child: VerticalDivider(width: 2,color: Colors.blueGrey)),

                  Icon(Icons.airplane_ticket_rounded,color: Colors.white54,),
                  SizedBox(
                    width: 90.h,
                    child: Text('${cubit.modell?.genres?.map((genre) => genre.name).join(", ")}',
                        style: GoogleFonts.roboto(color: Colors.white),),
                  )
                ],
              ),
              SizedBox(height: 25.h,),
              SizedBox(
                height: 40.h,
                child: Padding(
                  padding:  EdgeInsets.only(left: 30.0.w),
                  child: ListView.separated(
                    itemCount: cubit.detailsTaps.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder:(context, index) => InkWell(
                      onTap: ()
                      {
                        cubit.ChangeIndex(index);
                      },
                      child: Column(
                        children: [
                          Center(child: Text(cubit.detailsTaps[index],style: TextStyle(color: Colors.white,height: 2.h),)),

                          cubit.index==index?
                          Container(
                            width: 95.w,
                            height: 4.h,
                            color: Colors.blueGrey
                          ) :
                          Container(
                            width: 95.w,
                            height: 4.h,
                          ),

                        ],
                      ),
                    ),


                  ),
                ),
              ),
             cubit.index==0? Padding(
                padding:  EdgeInsets.symmetric(horizontal: 29.0.w),
                child: Text('${id!.overview}',style: GoogleFonts.poppins(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w300),),
              ):
             cubit.index==1?
             cubit.reviewModel!.results!.isEmpty?const Center(child:  Text('There are No Reviews Yet',style: TextStyle(color: Colors.white),),
             ):Expanded
                   (
                   child: ListView.separated(
                     physics: BouncingScrollPhysics(),
                     separatorBuilder: (context, index) =>Divider(color: Colors.white,),
                     shrinkWrap: true,
                     itemCount:cubit.reviewModel?.results?.length??0 ,
                     itemBuilder: (context, index) => Padding(
                       padding:  EdgeInsets.all(16.0.r),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               CircleAvatar(
                                 radius: 25,
                                 backgroundImage: cubit.reviewModel?.results?[index].authorDetails?.avatarPath != null?
                                 NetworkImage('${EndPoints.linkImage}/${cubit.reviewModel?.results?[index].authorDetails?.avatarPath}'):
                                 NetworkImage('https://img.freepik.com/premium-vector/3d-icon-user-profile-convex-volume-shape-person-circle_348818-1116.jpg'),
                               ),
                               SizedBox(width: 10.w,),
                               Text('${cubit.reviewModel?.results?[index].authorDetails?.username}',style: TextStyle(color: Colors.white),),
                               SizedBox(width: 10.w,),

                               Row(
                                 children: [
                                   Text('${cubit.reviewModel?.results?[index].authorDetails?.rating??'No rates'}',style: TextStyle(color: Colors.white),),
                                   Icon(Icons.star_border_outlined,color: Colors.white,)
                                 ],
                               ),

                             ],
                           ),

                           SizedBox(height: 15.h,),
                           SizedBox(
                               width: 270.w,
                               child: Text('${cubit.reviewModel?.results?[index].content}',style: TextStyle(color: Colors.white),),)
                         ],
                       ),
                     ),


                   ),
                 ) :
             Expanded(
               child: GridView.builder(
                 physics: BouncingScrollPhysics(),
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: cubit.nowPlayingModel?.results?.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 5,
                     childAspectRatio: 0.63,
                     crossAxisSpacing: 15),
                 itemBuilder: (context, current) =>
                     Padding(
                       padding:  EdgeInsets.all(15.0.r),
                       child: Column(
                         children: [
                           CircleAvatar(
                             radius: 50.r,
                             backgroundImage:cubit.castModel?.cast![current].profilePath != null?
                             NetworkImage('${EndPoints.linkImage}/${ cubit.castModel?.cast?[current].profilePath}'):
                             NetworkImage('https://img.freepik.com/premium-vector/3d-icon-user-profile-convex-volume-shape-person-circle_348818-1116.jpg')

                           ),
                           Text('${cubit.castModel?.cast?[current].originalName}',
                             style:  TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 14.sp),),
                           Divider(color: Colors.white,),
                           SizedBox(height: 10.h,),
                           Text('C h a r a c t e r  N a m e',
                             style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.normal,fontSize: 12.sp),),
                           SizedBox(height: 5.h,),
                           Text('${cubit.castModel?.cast?[current].character}',
                             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                         ],
                       ),
                     ),
               ),
             )
            ],
          ),
        );
      },
    );
  }
}
