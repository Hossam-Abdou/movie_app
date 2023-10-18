import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/newscubit/news_cubit.dart';
import '../../view_model/newscubit/news_state.dart';
import 'component/news_screen_component.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsWidget(
                  article1: cubit.newsModel?.articles?[index],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: cubit.newsModel?.articles?.length ?? 0,
            ),
          ),
        );
      },
    );
  }
}
