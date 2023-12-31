import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view/home/component/now_playing_screen.dart';
import 'package:socer_project/screens/view/home/component/popular_screen.dart';
import 'package:socer_project/screens/view/home/component/up_coming_screen.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/newscubit/news_cubit.dart';
import 'package:socer_project/screens/view_model/newscubit/news_state.dart';
import '../../../generated/l10n.dart';
import '../../view_model/movie_cubit/system_state.dart';
import 'component/home_tabs.dart';
import 'component/top_rated_screen.dart';
import 'component/trending_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Directionality(
          textDirection: cubit.currentLanguage == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  S
                      .of(context)
                      .title,
                  style: TextStyle(
                    color: cubit.dark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      cubit.changeMode();
                    },
                    icon: Icon(
                      Icons.brightness_4_sharp,
                      color: cubit.dark ? Colors.white : Colors.blueGrey,
                    ),
                  ),
                  BlocBuilder<NewsCubit, NewsState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          NewsCubit.get(context).toggleLanguage();
                          NewsCubit.get(context).getNews();
                          cubit.toggleLanguage();
                          cubit.changeLang();
                          cubit.getPopular();
                          cubit.getTrend();
                          cubit.getNowPlaying();
                          cubit.getUpComing();
                          cubit.getTopRated();
                        },
                        icon: Icon(
                          Icons.language,
                          color: cubit.dark ? Colors.white : Colors.blueGrey,
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        cubit.trendingMovieModel == null
                            ? const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        )
                            : const TrendingList(),
                        SizedBox(height: 10.h),
                        const HomeTabs(),
                        cubit.index == 0
                            ? const NowPlayingScreen()
                            : cubit.index == 1
                            ? const UpComingScreen()
                            : cubit.index == 2
                            ? const TopRatedScreen()
                            : const PopularScreen()
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
