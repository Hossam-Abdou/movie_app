part of 'system_cubit.dart';

@immutable
abstract class SystemState {}

class SystemInitial extends SystemState {}

class ChangeIndexState extends SystemState {}
class ModeSuccess extends SystemState {}


class GetLiveLoadingState extends SystemState{}
class GetLiveSuccessState extends SystemState{}
class GetLiveErrorState extends SystemState{}

class LoadingGetTopRatedMovieState extends SystemState {}

class SuccessGetTopRatedMovieState extends SystemState {}
class FailedGetTopRatedMovieState extends SystemState {}

class LoadingGetPopularMovieState extends SystemState {}
class SuccessGetPopularMovieState extends SystemState {}
class FailedGetPopularMovieState extends SystemState {}

class LoadingGetNowPlayingState extends SystemState {}
class SuccessGetNowPlayingState extends SystemState {}
class FailedGettNowPlayingtate extends SystemState {}

class LoadingGetUpComingState extends SystemState {}
class SuccessGetUpComingState extends SystemState {}
class FailedGettUpComingtate extends SystemState {}

class LoadingGetReviewState extends SystemState {}
class SuccessGetReviewState extends SystemState {}
class FailedGetReviewState extends SystemState {}

class GetCastLoadingState extends SystemState {}
class GetCastSuccessState extends SystemState {}
class GetCastErrorState extends SystemState {}

class GetTrendLoadingState extends SystemState {}
class GetTrendSuccessState extends SystemState {}
class GetTrendErrorState extends SystemState {}

class GetGenreLoadingState extends SystemState {}
class GetGenreSuccessState extends SystemState {}
class GetGenreErrorState extends SystemState {}

class GetVideoLoadingState extends SystemState {}
class GetVideoSuccessState extends SystemState {}
class GetVideoErrorState extends SystemState {}