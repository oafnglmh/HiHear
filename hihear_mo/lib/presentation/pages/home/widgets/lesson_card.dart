import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/core/constants/category.dart';
import 'package:hihear_mo/core/helper/lesson_helper.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/share/UserShare.dart';

class LessonCard extends StatefulWidget {
  final LessionEntity lesson;
  const LessonCard({super.key, required this.lesson});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shake;
  late final Animation<double> _fall;
  late final Animation<double> _rotate;
  late final Animation<double> _chainFade;

  bool _isLocked = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _shake = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.elasticIn),
    ));

    _fall = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeInQuart),
    ));

    _rotate = Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeInQuart),
    ));

    _chainFade = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    // Mở khóa bài đầu tiên
    if (widget.lesson.id == '1' || widget.lesson.id == 1) {
      _isLocked = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _unlock() {
    if (!_isLocked) return;
    _controller.forward().then((_) => setState(() => _isLocked = false));
  }

  @override
  Widget build(BuildContext context) {
    final colors = LessonHelper.getLessonColors(widget.lesson.id);
    final icon = LessonHelper.getIconForCategory(widget.lesson.category ?? '');
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: _isLocked ? _unlock : null,
      child: Stack(
        children: [
          // Card chính
          Opacity(
            opacity: _isLocked ? 0.6 : 1.0,
            child: Container(
              decoration: _cardDecoration(_isLocked ? Colors.grey : colors[0]),
              padding: const EdgeInsets.all(AppPadding.medium + 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _LessonIcon(icon: icon, colors: _isLocked ? [Colors.grey.shade400, Colors.grey.shade600] : colors),
                      const Spacer(),
                      _LessonBadge(title: widget.lesson.category ?? 'Bài học', color: _isLocked ? Colors.grey : colors[0]),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.lesson.title ?? 'Bài học',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle.copyWith(
                      color: _isLocked ? Colors.grey.shade600 : const Color(0xFF2D5016),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.lesson.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardDescription.copyWith(
                      color: _isLocked ? Colors.grey.shade500 : const Color(0xFF2D5016).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: AppPadding.medium),
                  _StartButton(lesson: widget.lesson, colors: colors, isLocked: _isLocked, l10n: l10n),
                ],
              ),
            ),
          ),

          // Layer khóa + hiệu ứng mở khóa
          if (_isLocked)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  final shakeOffset = _shake.value < 1 ? math.sin(_shake.value * math.pi * 4) * 5 : 0.0;
                  return Transform.translate(
                    offset: Offset(shakeOffset, 0),
                    child: Opacity(
                      opacity: _chainFade.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
                        ),
                        child: Center(
                          child: Transform.translate(
                            offset: Offset(0, _fall.value * 200),
                            child: Transform.rotate(
                              angle: _rotate.value * math.pi,
                              child: Container(
                                padding: const EdgeInsets.all(AppPadding.large),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFD4AF37),
                                      Color(0xFFB8941E),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.lock_rounded, size: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(Color borderColor) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.95),
          Colors.white.withOpacity(0.9),
        ],
      ),
      borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
      border: Border.all(
        color: _isLocked ? borderColor.withOpacity(0.3) : const Color(0xFFD4AF37),
        width: _isLocked ? 2 : 3,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 25,
          offset: const Offset(0, 10),
        ),
        if (!_isLocked)
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: -5,
            offset: const Offset(0, 15),
          ),
      ],
    );
  }
}

class _LessonIcon extends StatelessWidget {
  final String icon;
  final List<Color> colors;
  const _LessonIcon({required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.small + 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(icon, style: const TextStyle(fontSize: 24)),
    );
  }
}

class _LessonBadge extends StatelessWidget {
  final String title;
  final Color color;
  const _LessonBadge({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.small + 4, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.smallText.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final LessionEntity lesson;
  final List<Color> colors;
  final bool isLocked;
  final AppLocalizations l10n;

  const _StartButton({required this.lesson, required this.colors, required this.isLocked, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              final path = lesson.category == Category.grammar
                  ? '/grammar/${lesson.id}'
                  : '/vocab/${lesson.id}';
              context.go(path);
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLocked
                ? [Colors.grey.shade400, Colors.grey.shade600]
                : [
                    const Color(0xFFD4AF37),
                    const Color(0xFFB8941E),
                  ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.medium),
          boxShadow: [
            BoxShadow(
              color: (isLocked ? Colors.grey : const Color(0xFFD4AF37)).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLocked ? 'Đã khóa' : l10n.startButton, style: AppTextStyles.button),
            const SizedBox(width: 6),
            Icon(isLocked ? Icons.lock_rounded : Icons.arrow_forward_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}