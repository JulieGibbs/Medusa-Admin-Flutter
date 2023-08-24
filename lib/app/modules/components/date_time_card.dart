import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medusa_admin/app/data/service/storage_service.dart';

class DateTimeCard extends StatelessWidget {
  const DateTimeCard(
      {Key? key,
      required this.dateTime,
      this.onTap,
      required this.dateText,
      this.dateTimeTextStyle,
      this.dateTextStyle,
      this.borderColor})
      : super(key: key);
  final DateTime? dateTime;
  final void Function()? onTap;
  final String? dateText;
  final TextStyle? dateTimeTextStyle;
  final TextStyle? dateTextStyle;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final mediumTextStyle = Theme.of(context).textTheme.titleMedium;
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    const halfSpace = SizedBox(height: 6.0);
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                  color: borderColor ??
                      (dateTime != null ? Colors.grey : Colors.transparent))),
          child: dateTime == null
              ? Center(
                  child: Text(
                  dateText == null
                      ? 'Tap to select date'
                      : 'Tap to select ${dateText!.toLowerCase()} date',
                  style: largeTextStyle?.copyWith(color: lightWhite),
                ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            dateText == null
                                ? 'Date'
                                : '${dateText!.capitalize!} Date',
                            style: dateTextStyle ??
                                mediumTextStyle?.copyWith(color: lightWhite)),
                        halfSpace,
                        Text(formatDate(dateTime),
                            style: dateTimeTextStyle),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            dateText == null
                                ? 'Time'
                                : '${dateText!.capitalize!} Time',
                            style: dateTextStyle ??
                                mediumTextStyle?.copyWith(color: lightWhite)),
                        halfSpace,
                        Text(formatTime(dateTime),
                            style: dateTimeTextStyle),
                      ],
                    ),
                  ],
                )),
    );
  }
}

class DateCard extends StatelessWidget {
  const DateCard(
      {Key? key,
      required this.dateTime,
      this.onTap,
      required this.dateText,
      this.dateTimeTextStyle,
      this.dateTextStyle,
      this.borderColor})
      : super(key: key);
  final DateTime? dateTime;
  final void Function()? onTap;
  final String? dateText;
  final TextStyle? dateTimeTextStyle;
  final TextStyle? dateTextStyle;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final largeTextStyle = Theme.of(context).textTheme.titleLarge;
    final lightWhite = Get.isDarkMode ? Colors.white54 : Colors.black54;
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                  color: borderColor ??
                      (dateTime != null ? Colors.grey : Colors.transparent))),
          child: dateTime == null
              ? Center(
                  child: Text(
                  dateText == null
                      ? 'Tap to select date'
                      : 'Tap to select ${dateText!.toLowerCase()} date',
                  style: largeTextStyle?.copyWith(color: lightWhite),
                ))
              : Text(formatDate(dateTime),
                  style: dateTimeTextStyle)),
    );
  }
}

String formatDate(DateTime? datetime) {
  final format = StorageService.appSettings.dateFormatOptions;
  if (datetime == null) {
    return '';
  }
  return DateFormat(format.format()).format(datetime);
}

String formatTime(DateTime? datetime) {
  final format = StorageService.appSettings.timeFormatOptions;
  if (datetime == null) {
    return '';
  }
  return DateFormat(format.format()).format(datetime);
}
