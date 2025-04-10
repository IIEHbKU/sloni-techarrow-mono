import 'package:flutter/material.dart';
import 'package:techarrow_mobile_final/utils/task.dart';

class Cell {
  int number = 0;
  Color color = Color.fromARGB(255, 229, 228, 228);
  Color darkColor = Color.fromARGB(255, 196, 187, 187);
  Color lightColor = Colors.white;

  bool isFreezed = false;

  Cell(
      {int number = 0,
      Color color = const Color.fromARGB(255, 229, 228, 228)}) {
    this.number = number;
    this.color = color;
    darkColor = darken(color);
    lightColor = lighten(color);
  }

  Cell copy() {
    return Cell(number: number, color: color);
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  String toString() {
    return "$number";
  }
}

List<List<Cell>> createEmpty(int rows, int columns) {
  return List.generate(rows, (_) => List.generate(columns, (_) => Cell()));
}

bool moveDownShape(List<List<Cell>> matrix, int number) {
  for (int y = matrix.length - 1; y > 0; y--) {
    for (int x = 0; x < matrix[y].length; x++) {
      if ((matrix[y][x].number != 0 &&
          matrix[y][x].number != number &&
          matrix[y - 1][x].number == number)) {
        return false;
      }
      if (y == matrix.length - 1 && matrix[y][x].number == number) {
        return false;
      }
    }
  }

  for (int y = matrix.length - 2; y >= 0; y--) {
    for (int x = 0; x < matrix[0].length; x++) {
      if (matrix[y][x].number == number) {
        matrix[y + 1][x] = matrix[y][x].copy();
        matrix[y][x] = Cell();
      }
    }
  }

  return true;
}

moveLeftShape(List<List<Cell>> matrix, int number) {
  for (int y = 0; y < matrix.length; y++) {
    if (matrix[y][0].number == number) {
      return;
    }
    for (int x = 1; x < matrix[y].length - 1; x++) {
      if (matrix[y][x].number == number &&
          matrix[y][x - 1].number != 0 &&
          matrix[y][x - 1].number != number) {
        return;
      }
    }
  }
  for (int y = 0; y < matrix.length; y++) {
    for (int x = 0; x < matrix[y].length; x++) {
      if (matrix[y][x].number == number) {
        matrix[y][x - 1] = matrix[y][x].copy();
        matrix[y][x] = Cell();
      }
    }
  }
}

moveRightShape(List<List<Cell>> matrix, int number) {
  for (int y = 0; y < matrix.length; y++) {
    if (matrix[y][matrix[y].length - 1].number == number) {
      return;
    }
    for (int x = 0; x < matrix[y].length - 2; x++) {
      if (matrix[y][x].number == number &&
          matrix[y][x + 1].number != 0 &&
          matrix[y][x + 1].number != number) {
        return;
      }
    }
  }
  for (int y = 0; y < matrix.length; y++) {
    for (int x = matrix[y].length - 1; x >= 0; x--) {
      if (matrix[y][x].number == number) {
        matrix[y][x + 1] = matrix[y][x].copy();
        matrix[y][x] = Cell();
      }
    }
  }
}

void addShape(List<List<Cell>> matrix, int n, Color color, int number,
    {bool isVertical = false}) {
  if (isVertical) {
    for (int y = 0; y < n; y++) {
      matrix[y][matrix[y].length ~/ 2] = Cell(number: number, color: color);
    }
    return;
  }
  for (int i = 0; i < n; i++) {
    matrix[0][i] = Cell(number: number, color: color);
  }
}

void deleteNumber(List<List<Cell>> matrix, int number) {
  for (int y = 0; y < matrix.length; y++) {
    for (int x = 0; x < matrix[0].length; x++) {
      if (matrix[y][x].number == number) {
        matrix[y][x] = Cell(number: 0);
      }
    }
  }
}

void moveDownAllShapes(List<List<Cell>> matrix) {
  List<int> numbers = [];
  for (int y = matrix.length - 2; y > 0; y--) {
    for (int x = 0; x < matrix[y].length; x++) {
      if (matrix[y][x].number != 0 && !matrix[y][x].isFreezed) {
        numbers.add(matrix[y][x].number);
      }
    }
  }
  for (int n in numbers) {
    while (moveDownShape(matrix, n)) {}
  }
}

bool isFilledLine(List<List<Cell>> matrix, Set<int> alreadyFilledLines) {
  for (int y = 0; y < matrix.length; y++) {
    if (matrix[y].every((x) => (x.number != 0)) &&
        !alreadyFilledLines.contains(y)) {
      alreadyFilledLines.add(y);
      return true;
    }
  }
  return false;
}

void freeze(List<List<Cell>> matrix, int n) {
  for (List<Cell> row in matrix) {
    for (Cell cell in row) {
      if (cell.number == n) {
        cell.isFreezed = true;
      }
    }
  }
}

Map<String, dynamic> toJson(Task task) {
  return {
    'id': task.id,
    'title': task.title,
    'description': task.description,
    'startTime': task.startTime,
    'endTime': task.endTime,
    'colorId': task.colorId,
    'len': task.len,
  };
}
