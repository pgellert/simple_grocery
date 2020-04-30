import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool platformIsIOS(context){
  return Theme.of(context).platform == TargetPlatform.iOS;
}