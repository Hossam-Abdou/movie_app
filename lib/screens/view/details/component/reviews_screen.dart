import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/system_cubit.dart';

import '../../../../utils/end_points/urls.dart';

class ReviewsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
  builder: (context, state) {
    var cubit= SystemCubit.get(context);
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) =>Divider(color: Colors.white,),
        shrinkWrap: true,
        itemCount:cubit.reviewModel?.results?.length??0 ,
        itemBuilder: (context, index) => Padding(
          padding:  EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: cubit.reviewModel?.results?[index].authorDetails?.avatarPath != null?
                    NetworkImage('${EndPoints.linkImage}/${cubit.reviewModel?.results?[index].authorDetails?.avatarPath}'):
                    NetworkImage('https://img.freepik.com/premium-vector/3d-icon-user-profile-convex-volume-shape-person-circle_348818-1116.jpg'),
                  ),
                  SizedBox(width: 10.w,),
                  Text('${cubit.reviewModel?.results?[index].authorDetails?.username}',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 10.w,),

                  Row(
                    children: [
                      Text('${cubit.reviewModel?.results?[index].authorDetails?.rating??'No rates'}',style: TextStyle(color: Colors.white),),
                      Icon(Icons.star_border_outlined,color: Colors.white,)
                    ],
                  ),

                ],
              ),

              SizedBox(height: 15.h,),
              SizedBox(
                width: 270.w,
                child: Text('${cubit.reviewModel?.results?[index].content}',style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),


      ),
    );
  },
);
  }
}
