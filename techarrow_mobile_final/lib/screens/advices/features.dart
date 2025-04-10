import 'dart:math';
import 'dart:ui';

class AdvicesFeatures {
  Future<List<AdviceEntity>> getAdvices() async {
    final res = await Future.delayed(const Duration(seconds: 1));
    return List.generate(Random().nextInt(5) + 5, (index) {
      return AdviceEntity(
        color: Color.fromRGBO(
          Random().nextInt(100) + 155,
          Random().nextInt(100) + 155,
          Random().nextInt(100) + 155,
          1,
        ),
        title: 'Совет №${index + 1}',
        description: List.generate(
                Random().nextInt(5) + 1,
                (index) =>
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            .join("\n"),
      );
    });
  }
}

class AdviceEntity {
  AdviceEntity(
      {required this.color, required this.title, required this.description});

  final Color color;
  final String title;
  final String description;
}
