import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cubit.videoModel?.results?.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 25,
                          childAspectRatio:1,
                          crossAxisSpacing: 7),
                      itemBuilder: (context, current)
                        {
                          final YoutubePlayerController controller = YoutubePlayerController(
                            initialVideoId: '${cubit.videoModel?.results?[current].key}',
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                              loop: false,

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
                              SizedBox(
                                child: Text('${cubit.videoModel?.results?[current].name}',
                                  style: TextStyle(color: Colors.blueGrey[200],fontSize: 14.sp),
                                  maxLines: 2,overflow: TextOverflow.ellipsis,),
                              ),

                            ],
                          );
                        }

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
