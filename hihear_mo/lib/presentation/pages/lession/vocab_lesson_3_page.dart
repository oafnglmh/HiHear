import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_event.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class VocabLesson3Page extends StatelessWidget {
  const VocabLesson3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<VocabBloc>(),
      child: const _VocabLesson3View(),
    );
  }
}

class _VocabLesson3View extends StatelessWidget {
  const _VocabLesson3View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<VocabBloc, VocabState>(
          builder: (context, state) {
            final bloc = context.read<VocabBloc>();
            final vn = state.vocabList[state.currentIndex]['vn'];
            final en = state.vocabList[state.currentIndex]['word'];
            final placeholder = state.currentInput.isEmpty
                ? List.filled(en.length, "_").join(" ")
                : state.currentInput;

            final isChecking = state.inputCorrect != null;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    'Nhập vào bản dịch',
                    style: AppTextStyles.title.copyWith(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.amber,
                        size: 26,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        vn,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.gold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Text(
                    state.currentInput.isEmpty
                        ? List.filled(
                            state.vocabList[state.currentIndex]['word'].length,
                            "_",
                          ).join(" ")
                        : state.currentInput,
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.black54,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  if (isChecking) ...[
                    Text(
                      state.inputCorrect == true ? "Chính xác!" : "Sai rồi!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: state.inputCorrect == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1, end: 0),
                      duration: const Duration(seconds: 4),
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey[300],
                        color: AppColors.gold,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ] else ...[
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Nhập bản dịch ở đây...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                        ),
                      ),
                      onChanged: (value) => bloc.add(UpdateInput(value)),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.currentInput.isEmpty
                            ? null
                            : () => bloc.add(CheckInput(context)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          disabledBackgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Tiếp Theo",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
