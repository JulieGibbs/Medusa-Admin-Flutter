import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/fonts.dart';

Obx errorMessage(
        {required RxString errorMessage,
        required BuildContext context,
        double? emptyChildHeight,
        double? errorChildHeight,
        double? horizontalPadding,
        double? radius}) =>
    Obx(() {
      return AnimatedCrossFade(
        firstChild: SizedBox(height: emptyChildHeight ?? 50.0),
        secondChild: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 30.0),
          child: Container(
            height: errorChildHeight ?? 50.0,
            decoration: BoxDecoration(
              color: const Color(0xffFFE9E9),
              borderRadius: BorderRadius.circular(radius ?? FontSize.s24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Text(
                      errorMessage.value,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: ColorManager.red, fontSize: FontSize.s14),
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        crossFadeState: errorMessage.value.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
      );
    });
