import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:socer_project/homepage.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';
import 'package:socer_project/screens/view_model/newscubit/news_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/service/cache/sp_helper/sp_helper.dart';
import 'package:socer_project/service/dio_helper/dio_helper.dart';
import 'package:socer_project/utils/colors/custom_colors.dart';

import 'blocs/bloc_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await SharedPrefrenceHelper.init();
  var isDark = SharedPrefrenceHelper.getData(key: 'darkMode');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final isDark;

  MyApp(this.isDark);

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
                ..getTopRated()
                ..getPopular()
                ..getNowPlaying()
                ..getUpComing()
                ..getTrend()
                ..changeMode(
                  mode: isDark,
                ),
            ),
            BlocProvider(
              create: (context) => NewsCubit()..getNews(),
            )
          ],
          child: BlocBuilder<SystemCubit, SystemState>(
            builder: (context, state) {
              var cubit = SystemCubit.get(context);
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blueGrey,
                  appBarTheme: AppBarTheme(
                    elevation: 0.0,
                    backgroundColor: Colors.grey[300],
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.white10,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  ),
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blueGrey,
                  ),
                ),
                darkTheme: ThemeData(
                  appBarTheme: AppBarTheme(
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarColor: HexColor(
                        '333739',
                      ),
                    ),
                    backgroundColor: HexColor(
                      '333739',
                    ),
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  primaryColor: CustomColors.greyText,
                  primarySwatch: Colors.blueGrey,
                  scaffoldBackgroundColor: CustomColors.greyText,
                ),
                themeMode: cubit.dark ? ThemeMode.dark : ThemeMode.light,
                home: AnimatedSplashScreen(
                  splash: Center(
                    child: Lottie.asset(
                      'images/movie_splash.json',
                      width: 280.w,
                      height: 300.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  duration: 3000,
                  nextScreen: const HomeNavPage(),
                  backgroundColor: Colors.white,
                  splashTransition: SplashTransition.slideTransition,
                  curve: Curves.bounceIn,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
