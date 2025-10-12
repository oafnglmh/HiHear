import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_event.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_state.dart';
import 'vocab_lesson_2_page.dart';

class VocabLesson1Page extends StatelessWidget {
  const VocabLesson1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VocabBloc()..add(LoadVocab()),
      child: const _VocabLesson1View(),
    );
  }
}

class _VocabLesson1View extends StatelessWidget {
  const _VocabLesson1View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: BlocBuilder<VocabBloc, VocabState>(
          builder: (context, state) {
            final bloc = context.read<VocabBloc>();
            final current = state.vocabList[state.currentIndex];
            final isCorrect = state.isCorrect;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: Padding(
                key: ValueKey(state.currentIndex),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: (state.currentIndex + 1) / state.vocabList.length,
                      backgroundColor: Colors.grey[200],
                      color: AppColors.gold,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "Chọn từ đúng",
                      style: AppTextStyles.title.copyWith(
                        fontSize: 22,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.gold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          current["word"],
                          style: AppTextStyles.subtitle.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(current["image"], height: 180),
                    ),
                    const SizedBox(height: 30),

                    if (isCorrect == null)
                      ...List.generate(current["options"].length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.grayDark,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {
                              bloc.add(SelectAnswer(index));
                            },
                            child: Text(
                              current["options"][index],
                              style: AppTextStyles.subtitle,
                            ),
                          ),
                        );
                      }),

                    if (isCorrect != null) ...[
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.green.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Icon(
                                      isCorrect
                                          ? Icons.check_circle
                                          : Icons.close,
                                      color: isCorrect
                                          ? Colors.green
                                          : Colors.red,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            Text(
                              isCorrect ? "Chính Xác" : "Sai Rồi!",
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${current["word"]} – ${current["options"][current["correct"]]}",
                              style: AppTextStyles.subtitle.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      bloc.add(PlaySound(current["word"])),
                                  icon: const Icon(Icons.volume_up),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bookmark_border),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (state.currentIndex < state.vocabList.length - 1) {
                            bloc.add(NextWord());
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VocabLesson2Page(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Tiếp Theo",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
