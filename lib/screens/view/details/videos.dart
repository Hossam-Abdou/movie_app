import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../view_model/movie_cubit/system_state.dart';

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
          body: Padding(
            padding: EdgeInsets.all(12.0.r),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        itemCount: cubit.videoModel?.results?.length??0,
                          itemBuilder: (context, current) {
                            final YoutubePlayerController controller = YoutubePlayerController(
                              initialVideoId: '${cubit.videoModel?.results?[current].key}',
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                                loop: false,
                                showLiveFullscreenButton: false,

                              ),
                            );
                            return  Column(

                              children: [
                                InkWell(
                                  onTap: ()
                                  {
                                    controller.play();
                                  },
                                  child: SizedBox(
                                    height:130.h,
                                    child: YoutubePlayer(
                                      controller: controller,
                                      liveUIColor: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                SizedBox(
                                  child: Text('${cubit.videoModel?.results?[current].name}',
                                    style: TextStyle(color: cubit.dark? Colors.white:Colors.black,fontSize: 14.sp,fontWeight: FontWeight.bold),
                                    maxLines: 2,overflow: TextOverflow.ellipsis),
                                ),

                              ],
                            );
                          } ,

                      ),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
