import 'package:flutter/material.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget rowNextLevel({formatNum, point_frame}) {
  return Row(
    children: [
      textCustomGrey(text: 'Next Level: ', size: 16),
      textCustom(
        text: point_frame >= 0 && point_frame < 20000
            ? "${formatNum.format(20000 - point_frame)}"
            : point_frame >= 20000 && point_frame < 70000
                ? "${formatNum.format(70000 - point_frame)}"
                : point_frame >= 70000 && point_frame < 100000
                    ? "${formatNum.format(100000 - point_frame)}"
                    : point_frame >= 100000 && point_frame < 220000
                        ? "${formatNum.format(220000 - point_frame)}"
                        : point_frame >= 220000 && point_frame < 350000
                            ? "${formatNum.format(350000 - point_frame)}"
                            : point_frame >= 350000 && point_frame < 1000000
                                ? "${formatNum.format(1000000 - point_frame)}"
                                : point_frame >= 1000000
                                    ? "Max Level"
                                    : point_frame == -1
                                        ? "20,000"
                                        : point_frame == 0
                                            ? "20,000"
                                            : '...',
        size: 16,
      ),
    ],
  );
}
