import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/model/news_model.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({required this.article1, super.key});

  final Articles? article1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0.w),
      child: Container(
        //padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(218, 250, 245, 245),
          borderRadius: BorderRadius.circular(12.r),
          //  color: Colors.white
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Image.network(
              article1?.urlToImage ??
                  'https://www.skynewsarabia.com/images/v1/2023/02/16/1597614/1200/630/1-1597614.jpg',
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Text(
                    article1?.title ?? '365",',
                    textDirection: TextDirection.ltr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        article1?.source?.name ?? 'سعد محمود',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        article1?.publishedAt ?? '2022',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
