import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socer_project/screens/model/cast_model.dart';
import 'package:socer_project/screens/model/video_model.dart';
import 'package:socer_project/service/cache/secure_storage.dart';
import '../../model.dart';
import '../../utils/end_points/urls.dart';
import '../model/genre_model.dart';
import '../model/model.dart';
import '../model/now_playing_model.dart';
import '../model/popular_model.dart';
import '../model/review_model.dart';
import '../model/top_rated_model.dart';
import '../../service/dio_helper/dio_helper.dart';
import '../model/trending_model.dart';
import '../model/upcoming_model.dart';

part 'system_state.dart';

class SystemCubit extends Cubit<SystemState> {
  SystemCubit() : super(SystemInitial());

  static SystemCubit get(context) => BlocProvider.of(context);
  Model? model;

  getLive() async {
    emit(GetLiveLoadingState());
    await DioHelper.getData(
      url: 'v1/currentMatches',
      query: {"offset": 0, 'apikey': '9cf10217-963c-46dd-87df-5a189e7d6251'},
    ).then((value) {
      if (value.data['status'] == 200 || value.data['status'] == 201) {
        emit(GetLiveSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(GetLiveErrorState());
    });
  }

  TopRatedMovieModel? topRatedMovieModel;

  void GetTopRated() {
    emit(LoadingGetTopRatedMovieState());
    DioHelper.getData(url: EndPoints.topRated).then((value) {
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
        url: EndPoints.popular
    ).then((value) {
      popularMovieModel = PopularMovieModel.fromJson(value.data);

      emit(SuccessGetPopularMovieState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetPopularMovieState());
    });
  }


  GenreModel? genreModel;
  void getGenre() {
    emit(GetGenreLoadingState());
    DioHelper.getData(
        url: EndPoints.genre
    ).then((value) {
      genreModel = GenreModel.fromJson(value.data);

      emit(GetGenreSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetGenreErrorState());
    });
  }

VideoModel? videoModel;
  void getVideos(id) {
    emit(GetVideoLoadingState());
    DioHelper.getData(
        url: '${EndPoints.video}/$id/videos'
    ).then((value) {
      videoModel = VideoModel.fromJson(value.data);

      emit(GetVideoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetVideoErrorState());
    });
  }

Modell? modell;
  void getd(id) {
    emit(GetVideoLoadingState());
    DioHelper.getData(
        url: '${EndPoints.video}/$id'
    ).then((value) {
      modell = Modell.fromJson(value.data);

      emit(GetVideoSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetVideoErrorState());
    });
  }


  NowPlayingModel? nowPlayingModel;

  void getNowPlaying() {
    emit(LoadingGetNowPlayingState());
    DioHelper.getData(url: EndPoints.nowPlaying).then((value) {
      nowPlayingModel = NowPlayingModel.fromJson(value.data);

      emit(SuccessGetNowPlayingState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGettNowPlayingtate());
    });
  }

  UpcomingMovieModel? upcomingMovieModel;
  void getUpComing() {
    emit(LoadingGetUpComingState());
    DioHelper.getData(url: EndPoints.upcoming).then((value) {
      upcomingMovieModel = UpcomingMovieModel.fromJson(value.data);

      emit(SuccessGetUpComingState());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGettUpComingtate());
    });
  }

  TrendingMovieModel? trendingMovieModel;
  void gettrend() {

    emit(GetTrendLoadingState());
    DioHelper.getData(
        url: EndPoints.trend,

    ).then((value) {

      trendingMovieModel = TrendingMovieModel.fromJson(value.data);

      emit(GetTrendSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendErrorState());
    });
  }

  int index = 0;

  void ChangeIndex(currentIndex) {
    index = currentIndex;
    emit(ChangeIndexState());
  }
ReviewModel? reviewModel;
  void GetReview(int id){
    emit(LoadingGetReviewState());
    DioHelper.getData(
        url:'movie/$id/${EndPoints.reviews}' ,
        query: {
          'language':'en-US',
          'page':1
        }
    )
        .then((value) {
      reviewModel=ReviewModel.fromJson(value.data);
      emit(SuccessGetReviewState());
    }).catchError((error){
      print(error.toString());
      emit(FailedGetReviewState());
    });
  }

  CastModel? castModel;
  void GetCast(int id){
    emit(GetCastLoadingState());
    DioHelper.getData(
        url:'movie/$id/${EndPoints.credits}' ,
        query: {
          'language':'en-US',
          'page':1
        }
    )
        .then((value) {
      castModel=CastModel.fromJson(value.data);
      emit(GetCastSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCastErrorState());
    });
  }


  bool dark=false;
  void changeMode({bool? mode})
  async{
    if (mode != null) {
      dark = mode;
      emit(ModeSuccess());
    } else {
      dark = !dark;
      await SecureStorage().storage.write(key: 'darkMode', value: '$dark');
      emit(ModeSuccess());
    }
  }
  List<String> taps = [
        'Now Playing',
        'Upcoming',
        'Top Rated',
        'Popular'
  ];
  List<String> detailsTaps = [
    'About Movie',
    'Reviews',
    'Cast',
  ];
}
