import 'package:base_structure/core/data/localization/models/localize_res_model.dart';

import 'package:base_structure/general_imports.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: "🇺🇸",
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: "ar",
      languageName: 'Arabic',
      countryCode: 'Ar',
      languageCode: 'ar',
    ),
  ];

  static BoxDecoration commonDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(10.r),
    boxShadow: [
      BoxShadow(
        color: AppColors.black.withOpacity(.05),
        spreadRadius: 0,
        blurRadius: 28,
      ),
    ],
  );

  static const Map<String, List<String>> MEDICINE_FORMS = {
    "tablet": [
      ResourcePath.tablet_icon,
      ResourcePath.tablet_icon2,
      ResourcePath.tablet_icon3,
      ResourcePath.tablet_icon4,
      ResourcePath.tablet_icon5,
      ResourcePath.tablet_icon6,
      ResourcePath.tablet_icon7,
      ResourcePath.tablet_icon8,
      ResourcePath.tablet_icon9,
    ],
    "Capsule": [
      ResourcePath.capsule_icon,
    ],
    "Drops": [ResourcePath.drops_icon],
    "Spray": [ResourcePath.spray_icon],
    "Injection": [ResourcePath.injection_icon],
    "Cream": [ResourcePath.cream_icon],
    "Ointment": [ResourcePath.ointment_icon],
    "Gel": [ResourcePath.gel_icon]
  };
}
