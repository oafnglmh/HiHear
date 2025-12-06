import 'package:flutter/material.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'lesson_card.dart';

class LessonGrid extends StatelessWidget {
  final List<LessionEntity> lessons;

  const LessonGrid({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final lesson = lessons[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 600 + index * 150),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 30),
                child: Transform.scale(
                  scale: 0.85 + value * 0.15,
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                ),
              );
            },
            child: LessonCard(lesson: lesson),
          );
        },
        childCount: lessons.length,
      ),
    );
  }
}