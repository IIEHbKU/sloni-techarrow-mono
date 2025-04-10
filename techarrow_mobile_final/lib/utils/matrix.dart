import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/utils/matrixTools.dart';

Map<int, String> week = {
  0: "Пн",
  1: "Вт",
  2: "Ср",
  3: "Чт",
  4: "Пт",
  5: "Сб",
  6: "Вс",
};

class Matrix extends CustomPainter {
  List<List<Cell>> matrix = createEmpty(10, 10);

  Size curSize = Size(0, 0);
  int isRepaint = 0;

  int start = 8;
  int end = 20;

  bool isWeek = false;
  bool isReadOnly = false;

  @override
  void paint(Canvas canvas, Size size) {
    double kx = size.width / matrix[0].length;
    double ky = size.height / matrix.length;

    Paint paint = Paint();

    curSize = size;

    if (!isReadOnly) {
      if (isWeek) {
        for (int y = 12; y >= 0; y--) {
          TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: (20 - y).toString(),
              style: TextStyle(color: Colors.black),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(-kx / 2, y * ky - ky / 4));

          for (int x = 0; x <= 12; x++) {
            TextPainter textPainter = TextPainter(
              text: TextSpan(
                text: (week[x]).toString(),
                style: TextStyle(color: Colors.black),
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout();
            textPainter.paint(
                canvas,
                Offset(
                    x * kx + kx / 4,
                    matrix.length * (ky + 3) -
                        ky / 2 -
                        textPainter.height / 2));
          }
        }
      } else {
        for (int x = 0; x < 12; x++) {
          TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: (start + x).toString(),
              style: TextStyle(color: Colors.black),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          textPainter.paint(
              canvas,
              Offset(x * kx - textPainter.width / 2,
                  matrix.length * (ky + 3) - ky / 2 - textPainter.height / 2));
        }
      }
    }

    for (int y = 0; y < matrix.length; y++) {
      for (int x = 0; x < matrix[0].length; x++) {
        paint.color = matrix[y][x].darkColor;
        canvas.drawRect(
            Rect.fromPoints(
                Offset(x * kx, y * ky), Offset((x + 1) * kx, (y + 1) * ky)),
            paint);
        paint.color = matrix[y][x].color;
        canvas.drawRect(
            Rect.fromPoints(Offset(x * kx + kx / 10, y * ky + ky / 10),
                Offset((x + 1) * kx - kx / 10, (y + 1) * ky - ky / 10)),
            paint);
        paint.color = matrix[y][x].lightColor;
        canvas.drawRect(
            Rect.fromPoints(Offset(x * kx + kx / 10 * 3, y * ky + ky / 10 * 3),
                Offset((x + 1) * kx - kx / 10 * 6, (y + 1) * ky - ky / 10 * 6)),
            paint);
      }
    }
  }

  void weekChange() {
    isWeek = !isWeek;
    isRepaint = 0;
    matrix = createEmpty(12, 7);
  }

  void readOnly() {
    isReadOnly = !isReadOnly;
  }

  void setMatrix(List<List<Cell>> newMatrix) {
    matrix = newMatrix;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as Matrix).isRepaint != isRepaint;
  }

  Cell numberOnXY(Offset offset, double indentX, double indentY) {
    double kx = curSize.width / matrix[0].length;
    double ky = curSize.height / matrix.length;

    int cellX = ((offset.dx - indentX) / kx).floor();
    int cellY = ((offset.dy - indentY) / ky).floor();

    if (cellX < 0 ||
        cellX >= matrix[0].length ||
        cellY < 0 ||
        cellY >= matrix.length) {
      return Cell(number: 10);
    }

    return matrix[cellY][cellX];
  }
}
