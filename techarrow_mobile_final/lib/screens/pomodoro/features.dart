import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techarrow_mobile_final/api/api_service.dart';

class PomodoroScreenFeatures {
  String formatDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign$twoDigitMinutes:$twoDigitSeconds";
  }

  int getNextTimerMinutes(BuildContext context, Timer timer, int amount) {
    if (amount % 8 == 0) {
      return 15;
    }
    if (amount % 2 == 0) {
      return 5;
    }
    return 25;
  }

  //цвет
  Color getColor(int amount) {
    if (amount == 25) {
      return Colors.red;
    }
    if (amount == 5) {
      return Colors.green;
    }
    return Colors.blue;
  }

  int getAnimation(int amount, int previousAmount) {
    if (previousAmount == 25) {
      if (amount == 5) return 1;
      return 0;
    }
    if (amount == 15) {
      return 2;
    }
    return 3;
  }

  Future<void> markTaskAsCompleted(String taskId) async {
    await ApiService.api.apiTasksToCompletedTaskIdPut(taskId: taskId);
  }
}
