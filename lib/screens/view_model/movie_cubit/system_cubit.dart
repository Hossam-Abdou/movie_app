import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/model/cast_model.dart';
import 'package:socer_project/screens/model/video_model.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';
import '../../../generated/l10n.dart';
import '../../../service/cache/sp_helper/sp_helper.dart';
import '../../../utils/end_points/urls.dart';
import '../../model/model.dart';
import '../../model/now_playing_model.dart';
import '../../model/popular_model.dart';
import '../../model/review_model.dart';
import '../../model/search_model.dart';
import '../../model/top_rated_model.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../model/trending_model.dart';
import '../../model/upcoming_model.dart';
import '../../view/home/home_screen.dart';
import '../../view/home/search_screen.dart';
import '../../view/news/news_screen.dart';
import 'package:intl/intl.dart';

class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super(SystemInitial());

  static SystemCubit get(context) => BlocProvider.of(context);

  var search = TextEditingController();

  var searchKey = GlobalKey<FormState>();

// Bottom Navigation Bar

  final items = <Widget>[
    Icon(
      Icons.movie_sharp,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.search_rounded,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.newspaper_sharp,
      size: 30.sp,
      color: Colors.white,
    ),
  ];
  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeIndex());
  }

  List<Widget> layouts = [
    const HomeScreen(),
    const SearchScreen(),
    const NewsScreen(),
  ];

// home Screen

  TrendingMovieModel? trendingMovieModel;

  void getTrend() {
    emit(GetTrendLoadingState());
    DioHelper.getData(
        url: EndPoints.trend,
        query: {'language': '$currentLanguage'}).then((value) {
      trendingMovieModel = TrendingMovieModel.fromJson(value.data);

      emit(GetTrendSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendErrorState());
    });
  }

  TopRatedMovieModel? topRatedMovieModel;

  void getTopRated() {
    emit(LoadingGetTopRatedMovieState());
    DioHelper.getData(
        url: EndPoints.topRated,
        query: {'language': '$currentLanguage'}).then((value) {
      topRatedMovieModel = TopRatedMovieModel.fromJson(value.data);

      emit(SuccessGetTopRatedMovieState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetTopRatedMovieState());
    });
  }

  PopularMovieModel? popularMovieModel;

  void getPopular() {
    emit(LoadingGetPopularMovieState());
    DioHelper.getData(
        url: EndPoints.popular,
        query: {'language': '$currentLanguage'}).then((value) {
      popularMovieModel = PopularMovieModel.fromJson(value.data);

      emit(SuccessGetPopularMovieState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetPopularMovieState());
    });
  }

  NowPlayingModel? nowPlayingModel;

  void getNowPlaying() {
    emit(LoadingGetNowPlayingState());
    DioHelper.getData(
        url: EndPoints.nowPlaying,
        query: {'language': '$currentLanguage'}).then((value) {
      nowPlayingModel = NowPlayingModel.fromJson(value.data);

      emit(SuccessGetNowPlayingState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetNowPlayingState());
    });
  }

  UpcomingMovieModel? upcomingMovieModel;

  void getUpComing() {
    emit(LoadingGetUpComingState());
    DioHelper.getData(
        url: EndPoints.upcoming,
        query: {'language': '$currentLanguage'}).then((value) {
      upcomingMovieModel = UpcomingMovieModel.fromJson(value.data);

      emit(SuccessGetUpComingState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetUpComingState());
    });
  }

  SearchModel? searchModel;

  void getSearch(String movie) {
    emit(GetSearchLoadingState());
    DioHelper.getData(
        url: EndPoints.search,
        query: {'query': movie, 'language': '$currentLanguage'}).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState());
    });
  }

  // Home Tabs
  int index = 0;

  void changeIndex(currentIndex) {
    index = currentIndex;
    emit(ChangeIndexState());
  }

// change Language in App [ Localization ]
  String? currentLanguage;

  void toggleLanguage() {
    if (currentLanguage == 'ar') {
      currentLanguage = 'en';
      emit(LanguageChange());
    } else {
      currentLanguage = 'ar';
      emit(LanguageChange());
    }
  }

  changeLang() {
    if (Intl.getCurrentLocale() == 'en') {
      S.load(const Locale('ar'));
    } else {
      S.load(const Locale('en'));
    }
  }

// Dark Mode
  bool dark = false;

  void changeMode({bool? mode}) async {
    if (mode != null) {
      dark = mode;
      emit(ModeSuccess());
    } else {
      dark = !dark;
      SharedPrefrenceHelper.saveData(key: 'darkMode', value: dark);
      emit(ModeSuccess());
    }
  }

// details Screen

  VideoModel? videoModel;

  void getVideos(id) {
    emit(GetVideoLoadingState());
    DioHelper.getData(
      url: '${EndPoints.video}/$id/videos',
    ).then((value) {
      videoModel = VideoModel.fromJson(value.data);

      emit(GetVideoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetVideoErrorState());
    });
  }

  GenreModel? genreModel;

  void getGenre(id) {
    emit(GetVideoLoadingState());
    DioHelper.getData(url: '${EndPoints.video}/$id').then((value) {
      genreModel = GenreModel.fromJson(value.data);

      emit(GetVideoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetVideoErrorState());
    });
  }

  ReviewModel? reviewModel;

  void GetReview(int id) {
    emit(LoadingGetReviewState());
    DioHelper.getData(url: 'movie/$id/${EndPoints.reviews}', query: {
      'page': 1,
      'language': '$currentLanguage',
    }).then((value) {
      reviewModel = ReviewModel.fromJson(value.data);
      emit(SuccessGetReviewState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetReviewState());
    });
  }

  CastModel? castModel;

  void GetCast(int id) {
    emit(GetCastLoadingState());
    DioHelper.getData(
        url: 'movie/$id/${EndPoints.credits}',
        query: {'language': 'en-US', 'page': 1}).then((value) {
      castModel = CastModel.fromJson(value.data);
      emit(GetCastSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCastErrorState());
    });
  }
}
