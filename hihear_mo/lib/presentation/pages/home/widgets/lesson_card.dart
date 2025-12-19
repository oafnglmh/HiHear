import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/core/constants/category.dart';
import 'package:hihear_mo/core/helper/lesson_helper.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class LessonCard extends StatefulWidget {
  final LessionEntity lesson;
  const LessonCard({super.key, required this.lesson});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> with SingleTickerProviderStateMixin {
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
    final l10n = AppLocalizations.of(context)!;
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
    final l10n = AppLocalizations.of(context)!;
    final isLocked = widget.lesson.isLock;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          final shakeOffset = isLocked && _shakeAnimation.value > 0
              ? math.sin(_shakeAnimation.value * math.pi * 6) * 8
              : 0.0;

          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: Stack(
              children: [
                Opacity(
                  opacity: isLocked ? 0.6 : 1.0,
                  child: Container(
                    decoration: _cardDecoration(isLocked ? Colors.grey : colors[0]),
                    padding: const EdgeInsets.all(AppPadding.medium + 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _LessonIcon(
                              icon: icon,
                              colors: isLocked
                                  ? [Colors.grey.shade400, Colors.grey.shade600]
                                  : colors,
                            ),
                            const Spacer(),
                            _LessonBadge(
                              title: widget.lesson.category ?? 'Bài học',
                              color: isLocked ? Colors.grey : colors[0],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          widget.lesson.title ?? 'Bài học',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.cardTitle.copyWith(
                            color: isLocked
                                ? Colors.grey.shade600
                                : const Color(0xFF2D5016),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.lesson.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.cardDescription.copyWith(
                            color: isLocked
                                ? Colors.grey.shade500
                                : const Color(0xFF2D5016).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: AppPadding.medium),
                        _StartButton(
                          lesson: widget.lesson,
                          colors: colors,
                          isLocked: isLocked,
                          l10n: l10n,
                          onTap: _handleTap,
                        ),
                      ],
                    ),
                  ),
                ),

                if (isLocked)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
                      ),
                      child: Center(
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
                          child: const Icon(
                            Icons.lock_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _cardDecoration(Color borderColor) {
    final isLocked = widget.lesson.isLock;
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.95),
          Colors.white.withOpacity(0.9),
        ],
      ),
      borderRadius: BorderRadius.circular(AppRadius.xLarge + 4),
      border: Border.all(
        color: isLocked ? borderColor.withOpacity(0.3) : const Color(0xFFD4AF37),
        width: isLocked ? 2 : 3,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 25,
          offset: const Offset(0, 10),
        ),
        if (!isLocked)
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.small + 4,
        vertical: 4,
      ),
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
  final VoidCallback onTap;

  const _StartButton({
    required this.lesson,
    required this.colors,
    required this.isLocked,
    required this.l10n,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              color: (isLocked ? Colors.grey : const Color(0xFFD4AF37))
                  .withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLocked ? 'Đã khóa' : l10n.startButton,
              style: AppTextStyles.button,
            ),
            const SizedBox(width: 6),
            Icon(
              isLocked ? Icons.lock_rounded : Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}