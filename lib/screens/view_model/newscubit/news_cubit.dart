

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/news_model.dart';
import 'news_state.dart';

class newscubit extends Cubit<newsstate> {
  newscubit() : super(newsinitstate());
  static newscubit get(context) => BlocProvider.of<newscubit>(context);
NewsModel? newsmod;
  Future<void> getnews () async{
    emit(newsloadingstate());
    var dio= Dio();
    try{
      var response =await dio.get('https://newsapi.org/v2/top-headlines',queryParameters: 
      {
        'apiKey':'d8ca04bfd81f4d6680ff5f66cb7b74b4',
        'category':"entertainment",
        'country':'us',
      });
    print(response.data.toString());
    newsmod=NewsModel.fromJson(response.data);
    emit(newssuccessstate());
    }catch(e){
      emit(newserrorstate());
    }
  }
}