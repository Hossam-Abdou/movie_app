import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:socer_project/homepage.dart';
import 'package:socer_project/screens/view_model/newscubit/news_cubit.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/screens/view/home/home_screen.dart';
import 'package:socer_project/service/cache/secure_storage.dart';
import 'package:socer_project/service/dio_helper/dio_helper.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';

import 'blocs/bloc_observer.dart';
import 'screens/view/news/news_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => SystemCubit()
                    ..GetTopRated()
                    ..getPopular()
                    ..getNowPlaying()
                    ..getUpComing()
                    ..gettrend()
                    ..getGenre()),
              BlocProvider(
                create: (context) => newscubit()..getnews(),
              )
            ],
            child: BlocBuilder<SystemCubit, SystemState>(
              builder: (context, state) {
                var cubit = SystemCubit.get(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blueGrey,
                    scaffoldBackgroundColor: Colors.grey[400],
                    appBarTheme: AppBarTheme(
                      titleTextStyle: TextStyle(color: Colors.black),
                      backgroundColor: Colors.blueGrey,
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                  ),
                  darkTheme: ThemeData(
                    appBarTheme: AppBarTheme(
                      color: CustomColors.greyText,
                      iconTheme: IconThemeData(color: Colors.blueGrey),
                      titleTextStyle: TextStyle(color: Colors.white),
                    ),
                    primaryColor: CustomColors.greyText,
                    primarySwatch: Colors.blueGrey,
                    scaffoldBackgroundColor: CustomColors.greyText,
                  ),
                  themeMode: cubit.dark ? ThemeMode.dark : ThemeMode.light,
                  home: AnimatedSplashScreen(
                    splash: Center(
                      child: Lottie.asset('images/movie_splash.json',
                          width: 350.w, height: 350.h, fit: BoxFit.cover),
                    ),
                    duration: 3500,
                    nextScreen: HomeNavPage(),
                    backgroundColor: Colors.white,
                    splashTransition: SplashTransition.slideTransition,
                    curve: Curves.bounceIn,
                  ),
                );
              },
            ),
          );
        });
  }
}
