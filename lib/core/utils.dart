// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:base_structure/core/helpers/loadable_models/page_list_result.dart';
import 'package:base_structure/core/helpers/loadable_models/paginatable_list.dart';
import 'package:base_structure/core/shared_widgets/texts/localized_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_names.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';

class Utils {
  static final emailAddressRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final allowOnlyTwoDecimalRegex = RegExp(r'^\d+\.?\d{0,2}');

  ///Checks if the [value] is null or empty
  static bool isStringNullOrEmpty(String? value) =>
      value == null || value == '';

  static bool compareString(String? v1, String? v2, {bool ignoreCase = false}) {
    if (ignoreCase) {
      return v1?.toLowerCase() == v2?.toLowerCase();
    }
    return v1 == v2;
  }

  ///Gets predefined language font
  /// [lang] ISO2 code of the language
  static String getFontForLanguage(String lang) {
    switch (lang.toLowerCase()) {
      case "ar":
        return FontNames.arabic;
      default:
        return FontNames.english;
    }
  }

  static String dateFormateDayMonthYear(DateTime date, {String? format}) {
    DateFormat dateFormat = DateFormat(format ?? 'd MMM yyyy');
    String formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  static List<int> getDaysInCurrentMonth(int month) {
    int currentYear = DateTime.now().year;

    DateTime firstDayOfNextMonth = (month < 12)
        ? DateTime(currentYear, month + 1, 1)
        : DateTime(currentYear + 1, 1, 1);

    int lastDay = firstDayOfNextMonth.subtract(const Duration(days: 1)).day;

    List<int> days = List<int>.generate(lastDay, (i) => i + 1);

    return days;
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final hours =
        tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod; // Adjust for 12 AM/PM
    final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
    final minutes =
        tod.minute.toString().padLeft(2, '0'); // Ensure minutes have 2 digits
    return '$hours:$minutes $period';
  }

  ///Formats big numbers to short ones with number symbol
  static String compactNumber(num number) {
    NumberFormat compactNumberFormatter =
        NumberFormat.compactCurrency(symbol: '', decimalDigits: 0);
    return compactNumberFormatter.format(number);
  }

  ///Formats Duration to mm:ss
  static String formateDuration(Duration duration, String format,
      {String? lang}) {
    var date = DateTime(2022, 1, 1, 0, duration.inMinutes.abs(), 0, 0, 0);
    var formatter = DateFormat(format, lang ?? Get.locale!.languageCode);
    return formatter.format(date);
  }

  ///Checks if current local language is RTL
  static bool isRTL() {
    return Get.locale?.languageCode.toLowerCase() == "ar";
  }

  ///Generates a random color
  static Color generateRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  ///Checks if the [value] is a valid email based on [emailAddressRegex]
  static bool isValidEmailAddress(String value) =>
      emailAddressRegex.hasMatch(value);

  ///Get the [number] in decimal format
  /// 1000 => 1,000
  /// 1000000 => 1,000,000

  static String countryCodeToEmoji(String countryCode) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  static String getCardImage(String image) {
    return "assets/visual/png/$image.png";
  }

  static Future<String> downloadImageAsync(String imageUrl) async {
    try {
      Dio dio = Dio();
      // Create a temporary directory
      Directory tempDir = await getTemporaryDirectory();
      // Generate a unique filename for the image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // Build the path to save the image in the temporary directory
      String filePath = '${tempDir.path}/$fileName.jpg';
      // Download the image and save it to the specified path
      await dio.download(imageUrl, filePath);
      return filePath;
    } catch (e) {
      return "";
    }
  }

// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color convertHexStringToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String getUuId({bool removeDashes = false}) {
    var uuid = const Uuid().v4().toString();

    if (removeDashes) {
      return uuid.replaceAll("-", "");
    }
    return uuid;
  }

  static int getUuIdAsInt() {
    var uuid = const Uuid().v4();
    // Convert the UUID string to bytes (Uint8List)
    Uint8List uuidBytes = utf8.encode(uuid);
    // Hash the bytes to ensure a relatively unique integer
    int hash = uuidBytes.fold(0, (prev, elem) => prev + elem);
    return hash;
  }

  static T? getEnumFromString<T extends Enum>(
      String value, List<T> enumValues) {
    return enumValues.firstWhereOrNull(
        (element) => compareString(value, element.name.toString()));
  }

  static bool isNumber(String s) {
    return num.tryParse(s) != null;
  }

  ///Rounded up numbers depend on second digit
  /// roundUpToTenth(4.94) =~  4.9
  /// roundUpToTenth(4.96) =~  5
  static double roundUpToTenth(double number) {
    double roundedNumber = double.parse((number).toStringAsFixed(1));
    return roundedNumber;
  }

  static Color getRandomColor(List<Color> colorsList) {
    final random = Random();
    return colorsList[random.nextInt(colorsList.length)];
  }

// Method to convert TimeOfDay to Duration
  static Duration timeOfDayToDuration(TimeOfDay timeOfDay) {
    return Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
  }

  static TimeOfDay durationToTimeOfDay(Duration duration) {
    final int hours = duration.inHours % 24;
    final int minutes = duration.inMinutes % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }

  static final List<Color> colors = [
    const Color(0xFF097770),
    const Color(0xFF15D7B6),
    const Color(0xFFF58D7A),
    const Color(0xFF074E55),
    AppColors.white,
  ];

  static String valueOr(String? value, String replaceValue) {
    return Utils.isStringNullOrEmpty(value) ? replaceValue : value!;
  }

  static void showSnackBar(String title, String message,
      {Color color = AppColors.redOrange}) {
    Get.showSnackbar(
      GetSnackBar(
          title: title,
          message: message,
          maxWidth: 1.sw - 50.w,
          borderRadius: 20.r,
          backgroundColor: color,
          duration: const Duration(
            seconds: 4,
          )),
    );
  }

  static void handleDioException(DioException e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          debugPrint('Bad Request: ${e.response!.data}');
          break;
        case 401:
          debugPrint('Unauthorized: ${e.response!.data}');
          break;
        case 403:
          debugPrint('Forbidden: ${e.response!.data}');
          break;
        case 404:
          debugPrint('Not Found: ${e.response!.data}');
          break;
        case 500:
          debugPrint('Internal Server Error: ${e.response!.data}');
        case 508:
          debugPrint('Hit Server MultiTime: ${e.response!.data}');
          break;
        default:
          debugPrint('Unexpected status code: ${e.response!.statusCode}');
      }
    } else {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout');
      } else if (e.type == DioExceptionType.sendTimeout) {
        debugPrint('Send Timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        debugPrint('Receive Timeout');
      } else if (e.type == DioExceptionType.cancel) {
        debugPrint('Request Cancelled');
      } else if (e.type == DioExceptionType.connectionError) {
        debugPrint('Internet connection');
      } else if (e.type == DioExceptionType.unknown) {
        debugPrint('Unknown Error: ${e.message}');
      }
    }
  }

  static Future<T> safeApiCallAsync<T>({
    required Future<T> Function() task,
    Function(DioException error)? onError,
    Function? onFinally,
  }) async {
    try {
      return await task();
    } on DioException catch (error) {
      onError?.call(error);
      return Future.value((T == bool ? false : null) as T);
    } finally {
      await onFinally?.call();
    }
  }

  static Future<void> safeApiCallVoidAsync({
    required Future Function() task,
    Function(DioException error)? onError,
    Function? onFinally,
  }) {
    return safeApiCallAsync<void>(
      task: task,
      onError: onError,
      onFinally: onFinally,
    );
  }

  static Future<void> safeApiObxPaginatedCallVoidAsync<T>(
      {required Future<PageListResult<T>> Function(PaginatableList<T>) task,
      required Rx<PaginatableList<T>> initial,
      Function(DioException error)? onError,
      Function? onFinally,
      String? logMessage,
      bool showDefaultDialog = true,
      bool resetPage = false}) {
    return safeApiCallAsync<void>(
      task: () async {
        if (resetPage) {
          initial.value.clear();
        }

        if (!initial.value.hasMore || initial.value.isLoading) {
          return Future.value(null);
        }

        initial.value.isLoading = true;
        initial.refresh();

        var result = await task(initial.value);

        initial.value.totalCount = result.totalCount;
        initial.value.addRange(result.data);
        initial.value.moveNext();
      },
      onError: (ex) {
        initial.value.clear();
        onError?.call(ex);
      },
      onFinally: () {
        initial.value.isLoading = false;
        initial.refresh();
        onFinally?.call();
      },
    );
  }

  static List<String> getDayShortcuts() {
    List<String> dayShortcuts = [];
    // Iterate over days of the week starting from a Monday
    for (int i = 2; i <= 8; i++) {
      // Start from September 2, 2024 (Monday)
      DateTime date = DateTime(2024, 9, i);
      String dayShortcut =
          DateFormat('E').format(date); // Short form of the day
      dayShortcuts.add(dayShortcut);
    }
    return dayShortcuts;
  }

  static List<String> getMonths() {
    List<String> months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime date = DateTime(2024, i);
      String monthName = DateFormat('MMMM').format(date);
      months.add(monthName);
    }
    return months;
  }

  static Future<XFile?> showImagePickerOptions(BuildContext context) async {
    return showCupertinoModalPopup<XFile?>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: LocalizedText('Choose Image Source'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: LocalizedText('Camera'),
            onPressed: () async {
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              await Future.delayed(Duration.zero);
              Navigator.pop(context, pickedImage);
            },
          ),
          CupertinoActionSheetAction(
            child: LocalizedText('Gallery'),
            onPressed: () async {
              final pickedImage = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              await Future.delayed(Duration.zero);
              Navigator.pop(context, pickedImage);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context); // Close the bottom sheet
          },
          child: LocalizedText('Cancel'),
        ),
      ),
    );
  }

  static String parseLocalizedKey(String? key,
      {List<Object>? templatedValues, bool toUpperCase = false}) {
    var value = key?.tr ?? "NO_TEXT";
    // If there are templated values provided, replace the {#} placeholders.
    if (templatedValues != null && templatedValues.isNotEmpty) {
      for (var i = 0; i < templatedValues.length; i++) {
        // Replace the first occurrence of "{#}" with the corresponding templated value.
        value = value.replaceFirst("{#}", templatedValues[i].toString());
      }
    }

    return value;
  }

  static String getFirstCharsOfName(String name) {
    // Check if the name has multiple words or just one
    List<String> nameParts = name.trim().split(' ');
    String initials;

    if (nameParts.length > 1) {
      // If there are multiple words, take the first character of the first two words
      initials = nameParts[0][0] + nameParts[1][0];
    } else {
      // If there's only one word, take the first two characters from that word
      initials = nameParts[0].substring(0, nameParts[0].length >= 2 ? 2 : 1);
    }

    return initials.toUpperCase(); // Convert initials to uppercase
  }

  // Function to format TimeOfDay to two-line format like '8:00\nAM'
  static String timeFormatHourMinuteAmPmVertical(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Get time in 'h:mm' format (e.g., '8:00')
    String hourMinuteFormat = DateFormat('hh:mm').format(dateTime);

    // Get period (AM/PM)
    String amPmFormat = DateFormat('a').format(dateTime);

    // Return combined string with a newline separating time and period
    return '$hourMinuteFormat\n$amPmFormat';
  }

  static bool isTimeBeforeNow(TimeOfDay time) {
    final now = TimeOfDay.now();
    final nowDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      now.hour,
      now.minute,
    );

    final givenTimeDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    );

    // Compare the two DateTime objects
    return givenTimeDateTime.isBefore(nowDateTime);
  }
}
