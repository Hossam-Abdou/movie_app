
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';
import 'package:socer_project/screens/view/home/home_screen.dart';
import 'package:socer_project/service/dio_helper/dio_helper.dart';

import 'blocs/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();


  runApp(MyApp( ));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {


          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => SystemCubit()..GetTopRated()..getPopular()..getNowPlaying()..getUpComing()..gettrend()..getGenre())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                splash: Center(
                  child: Lottie.asset('images/movie_splash.json',
                      width: 350.w, height: 350.h, fit: BoxFit.cover),
                ),
                duration: 3500,
                nextScreen:HomeScreen(),
                backgroundColor: Colors.white,
                splashTransition: SplashTransition.slideTransition,
                curve: Curves.bounceIn,
              ),
            ),
          );
        });
  }
}

