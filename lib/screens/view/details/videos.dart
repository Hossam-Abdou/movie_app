import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/end_points/urls.dart';

class VideosScreen extends StatelessWidget {
  dynamic id;

  VideosScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Scaffold(
          backgroundColor: CustomColors.primaryButton,
          body: Padding(
            padding: EdgeInsets.all(12.0.r),
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                      child: Text('${id.title}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.sp),),) ,

                  SizedBox(height: 15.h,),

                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cubit.videoModel?.results?.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 25,
                          childAspectRatio:0.65,
                          crossAxisSpacing: 7),
                      itemBuilder: (context, current) =>
                          InkWell(
                            onTap: ()
                            {

                            },
                            child: Column(

                              children: [

                                SizedBox(
                                  child: Text('${cubit.videoModel?.results?[current].name}',
                                      style: TextStyle(color: Colors.blueGrey[200],fontSize: 14.sp),
                                  maxLines: 2,overflow: TextOverflow.ellipsis,),
                                ),
                                SizedBox(height: 10.h,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Image.network(
                                    '${EndPoints.linkImage}/${id!.posterPath}',
                                    height: 130.h,
                                    width:95.w,
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),

                                  ),
                                  child: TextButton(onPressed: ()
                                  {
                                    print('${cubit.videoModel?.results?[current].key}');
                                    launch('https://www.youtube.com/watch?v=${cubit.videoModel?.results?[current].key}');
                                  },
                                      child:  Text('Watch Video',style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold),),),
                                )
                              ],
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
