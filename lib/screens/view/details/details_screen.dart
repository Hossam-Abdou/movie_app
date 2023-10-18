import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socer_project/screens/view/details/videos.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/utils/end_points/urls.dart';
import 'package:socer_project/utils/widget/navigate.dart';
import '../../../generated/l10n.dart';
import '../../view_model/movie_cubit/system_state.dart';
import 'component/cast_screen.dart';
import 'component/details_tab.dart';
import 'component/reviews_screen.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic id;

  const DetailsScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SystemCubit.get(context);
        return Directionality(
          textDirection: cubit.currentLanguage == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).detailsAppBar,
                style: GoogleFonts.roboto(
                  color: cubit.dark ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: cubit.dark ? Colors.white : Colors.black,
                ),
              ),
            ),
            body: ListView(children: [
              Column(
                children: [
                  SizedBox(
                    height: 294.h,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              16.r,
                            ),
                            bottomLeft: Radius.circular(
                              16.r,
                            ),
                          ),
                          child: Image.network(
                            '${EndPoints.linkImage}/${id!.backdropPath}',
                            fit: BoxFit.cover,
                            height: 180.h,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          bottom: 120.h,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_border,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                '${id!.voteAverage}',
                                style: GoogleFonts.poppins(
                                  color: Colors.deepOrange,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 160.h,
                          left: 29.w,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                child: Image.network(
                                  '${EndPoints.linkImage}/${id!.posterPath}',
                                  height: 130.h,
                                  width: 95.w,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 180.w,
                                    child: Text(
                                      '${id!.title}',
                                      style: GoogleFonts.poppins(
                                        color: cubit.dark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // launch('https://www.youtube.com/watch?v=${id.id}');

                                      pushNavigate(
                                        context,
                                        VideosScreen(
                                          id: id,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      S.of(context).watchNow,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.blueGrey,
                      ),
                      Text(
                        '${id!.releaseDate}',
                        style: GoogleFonts.poppins(
                          color: cubit.dark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: 20.h,
                          child: const VerticalDivider(
                            width: 2,
                            color: Colors.blueGrey,
                          )),
                      const Icon(
                        Icons.language,
                        color: Colors.blueGrey,
                      ),
                      Text(
                        '${id!.originalLanguage}',
                        style: GoogleFonts.poppins(
                          color: cubit.dark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: const VerticalDivider(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const Icon(Icons.airplane_ticket_rounded,
                          color: Colors.blueGrey),
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          '${cubit.genreModel?.genres?.map((genre) => genre.name).join(" , ")}',
                          style: GoogleFonts.poppins(
                            color: cubit.dark ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  const DetailsTabs(),
                  cubit.index == 0
                      ? Padding(
                          padding: EdgeInsets.only(
                            right: 22.0.w,
                            left: 22.0.w,
                            bottom: 10.w,
                          ),
                          child: Text(
                            '${id!.overview}',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              color: cubit.dark ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : cubit.index == 1
                          ? cubit.reviewModel!.results!.isEmpty
                              ? Center(
                                  child: Text(
                                    S.of(context).noReviews,
                                    style: TextStyle(
                                      color: cubit.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                )
                              : const ReviewsScreen()
                          : const CastScreen()
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
