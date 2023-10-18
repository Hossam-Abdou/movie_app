import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_cubit.dart';
import 'package:socer_project/screens/view_model/movie_cubit/system_state.dart';


class Custom extends StatelessWidget {

  String? label;
  int? maxLines;
  final String? Function(String?)? validate;
  final TextEditingController controller;
  final String? initial;
  ValueChanged<String>? onChanged;
  bool? isPassword;

  IconData prefix;
  IconButton? suffix;

  Custom({super.key, 
    this.label,
    this.maxLines,
    this.validate,
    required this.controller,
    this.initial,
    this.onChanged,
    this.isPassword = false,
    required this.prefix,
    this.suffix});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
      builder: (context, state) {
        var cubit =SystemCubit.get(context);
        return TextFormField(
          onChanged: onChanged,
          validator: validate,
          showCursor: true,
          style: TextStyle(color: cubit.dark ? Colors.white : Colors.black),
          obscureText: isPassword!,
          cursorColor: Colors.blueAccent,
          decoration: InputDecoration(
            filled: true,
            fillColor: cubit.dark ? const Color(0xff333739): Colors.grey[200],
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            prefixIcon: Icon(prefix),
            prefixIconColor: Colors.blueGrey,
            label: Text(label!,
              style: const TextStyle(color: Colors.blueGrey),),
            suffixIcon: suffix,
            suffixIconColor: Colors.blueGrey[400],),
          controller: controller,
        );
      },
    );
  }
}


