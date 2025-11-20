import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';
import 'package:hihear_mo/presentation/pages/lession/vocabulary/models/vocab_question.dart';

class QuestionContent extends StatelessWidget {
  final VocabQuestion question;
  final bool hasAnswered;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;

  const QuestionContent({
    super.key,
    required this.question,
    required this.hasAnswered,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuestionCard(question: question.question),
            const SizedBox(height: AppPadding.xLarge),
            _AnswerOptions(
              question: question,
              hasAnswered: hasAnswered,
              selectedAnswer: selectedAnswer,
              onAnswerSelected: onAnswerSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String question;
  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.xLarge),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(AppRadius.xLarge),
        border: Border.all(
          color: AppColors.goldLight.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.large),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.goldLight.withOpacity(0.2),
                  AppColors.goldDark.withOpacity(0.2),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Text('❓', style: TextStyle(fontSize: 40)),
          ),
          const SizedBox(height: AppPadding.large),
          Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerOptions extends StatelessWidget {
  final VocabQuestion question;
  final bool hasAnswered;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;

  const _AnswerOptions({
    required this.question,
    required this.hasAnswered,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final answers = [question.correctAnswer, question.wrongAnswer]..shuffle();

    return Column(
      children: answers
          .map((answer) => Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.medium),
                child: _AnswerOption(
                  answer: answer,
                  isSelected: selectedAnswer == answer,
                  isCorrect: answer == question.correctAnswer,
                  hasAnswered: hasAnswered,
                  onTap: () => onAnswerSelected(answer),
                ),
              ))
          .toList(),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final showResult = hasAnswered && isSelected;
    final Color borderColor;
    final Color backgroundColor;
    final double elevation;
    final Widget? trailing;

    if (showResult) {
      if (isCorrect) {
        borderColor = AppColors.goldLight;
        backgroundColor = AppColors.goldLight.withOpacity(0.15);
        elevation = 8;
        trailing = _buildIcon(AppColors.goldLight, Icons.check);
      } else {
        borderColor = AppColors.textSecondary;
        backgroundColor = AppColors.textSecondary.withOpacity(0.1);
        elevation = 0;
        trailing = _buildIcon(AppColors.textSecondary, Icons.close);
      }
    } else {
      borderColor = AppColors.goldLight.withOpacity(0.3);
      backgroundColor = Colors.white.withOpacity(0.95);
      elevation = 0;
      trailing = null;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.large,
          vertical: AppPadding.large + 4,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(color: borderColor, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.2),
              blurRadius: elevation,
              offset: Offset(0, elevation / 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppPadding.medium),
              trailing,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
