import 'package:flutter/material.dart';

void pushNavigate(context, secondScreen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => secondScreen,
      ),
    );

void pushReplace(context, secondScreen) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => secondScreen,
      ),
    );
