import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/helper/lesson_helper.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/category.dart';

class LessonPath extends StatelessWidget {
  final List<LessionEntity> lessons;

  const LessonPath({super.key, required this.lessons});

  Map<String, List<LessionEntity>> _groupLessonsByLevel() {
    final Map<String, List<LessionEntity>> grouped = {};
    for (var lesson in lessons) {
      final level = lesson.level ?? 'A1';
      if (!grouped.containsKey(level)) {
        grouped[level] = [];
      }
      grouped[level]!.add(lesson);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedLessons = _groupLessonsByLevel();
    final levels = groupedLessons.keys.toList()..sort();
    
    List<Widget> pathItems = [];
    
    for (var level in levels) {
      pathItems.add(_LevelHeader(level: level));
      
      final lessonsInLevel = groupedLessons[level]!;
      for (int i = 0; i < lessonsInLevel.length; i++) {
        pathItems.add(_LessonPathItem(
          lesson: lessonsInLevel[i],
          index: i,
        ));
      }
    }
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + index * 80),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: pathItems[index],
          );
        },
        childCount: pathItems.length,
      ),
    );
  }
}

class _LevelHeader extends StatelessWidget {
  final String level;

  const _LevelHeader({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppPadding.large,
        right: AppPadding.large,
        top: AppPadding.xxLarge,
        bottom: AppPadding.large,
      ),
      padding: const EdgeInsets.all(AppPadding.large),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF58CC02),
            Color(0xFF46A302),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF58CC02).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SECTION 1, UNIT 1',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  level,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.book_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonPathItem extends StatefulWidget {
  final LessionEntity lesson;
  final int index;

  const _LessonPathItem({
    required this.lesson,
    required this.index,
  });

  @override
  State<_LessonPathItem> createState() => _LessonPathItemState();
}

class _LessonPathItemState extends State<_LessonPathItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.lesson.isLock) {
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });
      _showLockedDialog();
    } else {
      final path = widget.lesson.category == Category.grammar
          ? '/grammar/${widget.lesson.id}'
          : '/vocab/${widget.lesson.id}';
      context.go(path);
    }
  }

  void _showLockedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                ),
                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
              child: const Icon(Icons.lock_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Bài học bị khóa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D5016),
                ),
              ),
            ),
          ],
        ),
        content: const Text(
          'Bạn cần hoàn thành các bài học trước đó để mở khóa bài học này.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF2D5016),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: const Color(0xFFD4AF37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
            ),
            child: const Text(
              'Đã hiểu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = LessonHelper.getLessonColors(widget.lesson.id);
    final icon = LessonHelper.getIconForCategory(widget.lesson.category ?? '');
    final isLocked = widget.lesson.isLock;

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final shakeOffset = isLocked && _shakeAnimation.value > 0
            ? math.sin(_shakeAnimation.value * math.pi * 6) * 5
            : 0.0;

        return Transform.translate(
          offset: Offset(shakeOffset, 0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.medium,
              ),
              child: Column(
                children: [
                  if (widget.index > 0)
                    Container(
                      width: 4,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey.shade300,
                            isLocked ? Colors.grey.shade400 : colors[0].withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  
                  GestureDetector(
                    onTap: _handleTap,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isLocked
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey.shade300,
                                      Colors.grey.shade500,
                                    ],
                                  )
                                : LinearGradient(
                                    colors: colors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            border: Border.all(
                              color: Colors.white,
                              width: 6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (isLocked ? Colors.grey.shade400 : colors[0])
                                    .withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLocked
                                ? Icon(
                                    Icons.lock_rounded,
                                    size: 40,
                                    color: Colors.grey.shade700,
                                  )
                                : Text(
                                    icon,
                                    style: const TextStyle(fontSize: 45),
                                  ),
                          ),
                        ),

                        if (!isLocked)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _ProgressRingPainter(
                                progress: 0.3,
                                color: colors[0],
                              ),
                            ),
                          ),

                        if (!isLocked)
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.yellow.shade700,
                                  ),
                                );
                              }),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ProgressRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 3;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final progressPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.7),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      const startAngle = -math.pi / 2;
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}