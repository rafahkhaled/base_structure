import 'dart:async';
import 'dart:convert';

import 'package:base_structure/core/controllers/language_controller.dart';
import 'package:base_structure/core/data/localization/models/localize_res_model.dart';
import 'package:base_structure/core/singletons/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/locales/${languageModel.languageCode}.json');

    debugPrint(jsonStringValues);
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
