

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/news_model.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitState());
  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);


  NewsModel? newsModel;

  Future<void> getNews () async{
    emit(NewsLoadingState());
    var dio= Dio();
    try{
      var response =await dio.get('https://newsapi.org/v2/top-headlines',queryParameters: 
      {
        'apiKey':'d8ca04bfd81f4d6680ff5f66cb7b74b4',
        'category':"entertainment",
        'country':'$country',
      });
    newsModel=NewsModel.fromJson(response.data);
    emit(NewsSuccessState());
    }catch(e){
      emit(NewsErrorState());
    }
  }


  String? country;

  void toggleLanguage() {
    if (country == 'eg') {
      country = 'us';
      emit(LanguageChange());
    } else {
      country = 'eg';
      emit(LanguageChange());
    }
  }









}