import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view/details/details_screen.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';
import 'package:socer_project/utils/end_points/urls.dart';
import 'package:socer_project/utils/widget/navigate.dart';
import 'package:socer_project/utils/widget/textfield.dart';

import '../../../generated/l10n.dart';
import '../../../utils/colors/custom_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Directionality(
          textDirection:
              BlocProvider.of<SystemCubit>(context).currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.0.r),
              child: SafeArea(
                child: Column(
                  children: [
                    Custom(
                      controller: cubit.search,
                      label: S.of(context).search,
                      prefix: Icons.search,
                      validate: (value) {
                        if (value!.isEmpty) return 'text to search';
                        return null;
                      },
                      onChanged: (String value) {
                        cubit.getSearch(value);
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.searchModel?.results?.length ?? 0,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.h),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            cubit.GetReview(
                                cubit.searchModel!.results![index].id as int);
                            cubit.getGenre(
                                cubit.searchModel!.results![index].id as int);
                            cubit.GetCast(
                                cubit.searchModel!.results![index].id as int);
                            cubit.getVideos(
                                cubit.searchModel!.results![index].id as int);
                            pushNavigate(
                              context,
                              DetailsScreen(
                                id: cubit.searchModel?.results?[index],
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  color: CustomColors.primaryButton,
                                ),
                                child: cubit.searchModel?.results?[index]
                                            .backdropPath ==
                                        null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          color: Colors.blueGrey,
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'No Image',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      )
                                    : Image.network(
                                        '${EndPoints.linkImage}/${cubit.searchModel?.results?[index].backdropPath}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170.w,
                                    child: Text(
                                      '${cubit.searchModel?.results?[index].title}',
                                      style: TextStyle(
                                        color: cubit.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
