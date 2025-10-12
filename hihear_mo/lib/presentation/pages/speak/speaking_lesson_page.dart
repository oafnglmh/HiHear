import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/presentation/widgets/wave_painter.dart';
import '../../blocs/speaking/speaking_bloc.dart';
import '../../blocs/speaking/speaking_event.dart';
import '../../blocs/speaking/speaking_state.dart';

class SpeakingLessonPage extends StatefulWidget {
  const SpeakingLessonPage({super.key});

  @override
  State<SpeakingLessonPage> createState() => _SpeakingLessonPageState();
}

class _SpeakingLessonPageState extends State<SpeakingLessonPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpeakingBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "Speaking Lesson",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<SpeakingBloc, SpeakingState>(
            builder: (context, state) {
              final bloc = context.read<SpeakingBloc>();
              final lesson = bloc.lessons[state.currentLesson];

              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                color: AppColors.gold,
                              ),
                              SizedBox(width: 8),
                              Text(
                                lesson,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 150),
                    ],
                  ),

                  if (!state.showPopup)
                    Positioned(
                      bottom: 40,
                      child: GestureDetector(
                        onTap: () =>
                            context.read<SpeakingBloc>().add(ToggleRecording()),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _waveController,
                                builder: (_, __) => CustomPaint(
                                  painter: WavePainter(
                                    animationValue: _waveController.value,
                                    active: state.isRecording,
                                    color: AppColors.primary.withOpacity(0.5),
                                  ),
                                  size: const Size(150, 150),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.isRecording
                                      ? Colors.redAccent
                                      : AppColors.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          (state.isRecording
                                                  ? Colors.redAccent
                                                  : AppColors.primary)
                                              .withOpacity(0.5),
                                      blurRadius: 25,
                                      spreadRadius: state.isRecording ? 10 : 5,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  state.isRecording ? Icons.stop : Icons.mic,
                                  color: Colors.white,
                                  size: 42,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  if (state.showPopup)
                    Positioned.fill(child: _buildFeedbackPopup(context, state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackPopup(BuildContext context, SpeakingState state) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => context.read<SpeakingBloc>().add(HideFeedbackPopup()),
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedSlide(
            offset: state.showPopup ? Offset.zero : const Offset(0, 1),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: state.showPopup ? 1 : 0,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "⭐ ${state.score.toStringAsFixed(1)} / 100",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.feedback,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<SpeakingBloc>().add(
                              HideFeedbackPopup(),
                            );
                          },
                          icon: const Icon(
                            Icons.replay,
                            color: AppColors.textWhite,
                          ),
                          label: const Text(
                            "Retry",
                            style: TextStyle(color: AppColors.textWhite),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<SpeakingBloc>().add(
                              NextLesson(context),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.textWhite,
                          ),
                          label: const Text(
                            "Next",
                            style: TextStyle(color: AppColors.textWhite),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
