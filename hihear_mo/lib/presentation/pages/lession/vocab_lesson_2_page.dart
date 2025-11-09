import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_bloc.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_event.dart';
import 'package:hihear_mo/presentation/blocs/vocab/vocab_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
class VocabLesson2Page extends StatelessWidget {
  const VocabLesson2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VocabBloc()..add(LoadVocab()),
      child: const _VocabLesson2View(),
    );
  }
}

class _VocabLesson2View extends StatefulWidget {
  const _VocabLesson2View();

  @override
  State<_VocabLesson2View> createState() => _VocabLesson2ViewState();
}

class _VocabLesson2ViewState extends State<_VocabLesson2View> {
  String? selectedEnglish;
  List<Map<String, dynamic>>? englishList;
  List<Map<String, dynamic>>? vietnameseList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: BlocBuilder<VocabBloc, VocabState>(
          builder: (context, state) {
            final bloc = context.read<VocabBloc>();
            final allMatched = state.matched.length == state.vocabList.length;

            if (state.vocabList.isNotEmpty &&
                (englishList == null || vietnameseList == null)) {
              englishList = List<Map<String, dynamic>>.from(state.vocabList)
                ..shuffle();
              vietnameseList = List<Map<String, dynamic>>.from(state.vocabList)
                ..shuffle();
            }
            if (englishList == null || vietnameseList == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cùng ôn lại nào",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  const SizedBox(height: 50),

                  Expanded(
                    child: Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: englishList!.map((enItem) {
                                final matched = state.matched.containsKey(
                                  enItem['word'],
                                );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: GestureDetector(
                                    onTap: matched
                                        ? null
                                        : () => setState(() {
                                            selectedEnglish = enItem['word'];
                                          }),
                                    child: AnimatedContainer(
                                      width: 150,
                                      height: 65,
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: matched
                                            ? Colors.green.withOpacity(0.15)
                                            : (selectedEnglish == enItem['word']
                                                  ? AppColors.background
                                                        .withOpacity(0.1)
                                                  : Colors.white),
                                        border: Border.all(
                                          color: matched
                                              ? Colors.green
                                              : Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        enItem['word'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              children: vietnameseList!.map((vnItem) {
                                final matched = state.matched.containsValue(
                                  vnItem['vn'],
                                );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: GestureDetector(
                                    onTap: matched
                                        ? null
                                        : () {
                                            if (selectedEnglish != null) {
                                              context.read<VocabBloc>().add(
                                                MatchWord(
                                                  selectedEnglish!,
                                                  vnItem['vn'],
                                                ),
                                              );
                                              setState(() {
                                                selectedEnglish = null;
                                              });
                                            }
                                          },
                                    child: AnimatedContainer(
                                      width: 150,
                                      height: 65,
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: matched
                                            ? Colors.green.withOpacity(0.15)
                                            : Colors.white,
                                        border: Border.all(
                                          color: matched
                                              ? Colors.green
                                              : Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        vnItem['vn'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (allMatched)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 52,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(42),
                          ),
                          backgroundColor: AppColors.background,
                        ),
                        child: const Text(
                          "Tiếp tục",
                          style: TextStyle(color: AppColors.textWhite),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
