import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';

class SpeakingLessonPage extends StatefulWidget {
  const SpeakingLessonPage({super.key});

  @override
  State<SpeakingLessonPage> createState() => _SpeakingLessonPageState();
}

class _SpeakingLessonPageState extends State<SpeakingLessonPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late stt.SpeechToText _speech;

  bool _isRecording = false;
  String _recognizedText = '';
  int _currentLessonIndex = 0;
  int _currentSentenceIndex = 0;
  List<SpeakingResult> _results = [];
  bool _showFeedback = false;
  double _accuracy = 0.0;
  late final l10n = AppLocalizations.of(context)!;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    context.read<LessonBloc>().add(const LessonEvent.loadLessonBySpeak());
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _speech.stop();
    super.dispose();
  }

  void _toggleRecording(String targetText) async {
    if (_isRecording) {
      await _speech.stop();
      setState(() => _isRecording = false);
      _analyzeSpeech(targetText);
    } else {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isRecording = true;
          _recognizedText = '';
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
            });
          },
        );
      }
    }
  }

  void _analyzeSpeech(String targetText) {
    if (_recognizedText.isEmpty) {
      _showErrorDialog(l10n.speakingLessonErrorNoSpeech);
      return;
    }
    final accuracy = _calculateAccuracy(_recognizedText, targetText);
    final mistakes = _findMistakes(_recognizedText, targetText);

    setState(() {
      _accuracy = accuracy;
      _results.add(
        SpeakingResult(
          targetText: targetText,
          recognizedText: _recognizedText,
          accuracy: accuracy,
          mistakes: mistakes,
        ),
      );
      _showFeedback = true;
    });
  }

  double _calculateAccuracy(String recognized, String target) {
    final recognizedWords = recognized.toLowerCase().split(' ');
    final targetWords = target.toLowerCase().split(' ');

    int correctWords = 0;
    for (int i = 0; i < targetWords.length && i < recognizedWords.length; i++) {
      if (_isSimilar(recognizedWords[i], targetWords[i])) {
        correctWords++;
      }
    }

    return (correctWords / targetWords.length) * 100;
  }

  bool _isSimilar(String word1, String word2) {
    if (word1 == word2) return true;
    if (word1.length != word2.length) return false;

    int differences = 0;
    for (int i = 0; i < word1.length; i++) {
      if (word1[i] != word2[i]) differences++;
    }

    return differences <= 1;
  }

  List<String> _findMistakes(String recognized, String target) {
    final recognizedWords = recognized.toLowerCase().split(' ');
    final targetWords = target.toLowerCase().split(' ');
    final mistakes = <String>[];

    for (int i = 0; i < targetWords.length; i++) {
      if (i >= recognizedWords.length ||
          !_isSimilar(recognizedWords[i], targetWords[i])) {
        mistakes.add(targetWords[i]);
      }
    }

    return mistakes;
  }

  void _nextSentence(LessionEntity lesson) {
    final sentences = lesson.exercises.first.speakings?.first.read ?? [];
    if (_currentSentenceIndex < sentences.length - 1) {
      setState(() {
        _currentSentenceIndex++;
        _showFeedback = false;
        _recognizedText = '';
      });
    } else {
      _nextLesson();
    }
  }

  void _nextLesson() {
    final state = context.read<LessonBloc>().state;

    state.whenOrNull(
      data: (lessons) async {
        final currentLesson = lessons[_currentLessonIndex];
        context.read<LessonBloc>().add(
          LessonEvent.saveCompleteLesson(
            lessonId: currentLesson.id,
            userId: UserShare().id ?? '',
          ),
        );

        if (_currentLessonIndex < lessons.length - 1) {
          setState(() {
            _currentLessonIndex++;
            _currentSentenceIndex = 0;
            _showFeedback = false;
            _recognizedText = '';
            _results.clear();
          });
        } else {
          _showCompletionDialog();
        }
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.speakingLessonCompletionTitle),
        content: Text(l10n.speakingLessonCompletionMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            child: Text(l10n.speakingLessonCompletionMessage),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7F4E),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          l10n.speakingLessonTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    BlocBuilder<LessonBloc, LessonState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          data: (lessons) => Text(
                            '${_currentLessonIndex + 1}/${lessons.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          orElse: () => const Text(
                            '0/0',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text(l10n.speakingLessonInitial)),
            loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFF1B7F4E)),
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Lỗi: $message',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<LessonBloc>().add(
                      const LessonEvent.loadLessonBySpeak(),
                    ),
                    child: Text(l10n.speakingLessonErrorRetry),
                  ),
                ],
              ),
            ),
            data: (lessons) {
              if (lessons.isEmpty) {
                return Center(child: Text(l10n.speakingLessonNoLesson));
              }

              final lesson = lessons[_currentLessonIndex];
              final exercise = lesson.exercises.first;
              final speakings = exercise.speakings ?? [];

              if (speakings.isEmpty) {
                return Center(child: Text(l10n.speakingLessonNoContent));
              }

              final speaking = speakings.first;
              final sentences = speaking.read ?? [];

              if (sentences.isEmpty ||
                  _currentSentenceIndex >= sentences.length) {
                return Center(child: Text(l10n.speakingLessonNoSentence));
              }

              final currentSentence = sentences[_currentSentenceIndex];

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildProgressIndicator(sentences.length),

                        const SizedBox(height: 24),

                        _buildLessonInfoCard(lesson, exercise),

                        const SizedBox(height: 24),

                        _buildSentenceCard(currentSentence),

                        const SizedBox(height: 24),

                        if (_recognizedText.isNotEmpty)
                          _buildRecognitionResult(),

                        const SizedBox(height: 32),

                        Center(child: _buildMicrophoneButton(currentSentence)),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                  if (_showFeedback)
                    _buildFeedbackPopup(lesson, currentSentence),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(int totalSentences) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.speakingLessonProgress(_currentSentenceIndex + 1,totalSentences),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              Text(
                '${((_currentSentenceIndex + 1) / totalSentences * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B7F4E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (_currentSentenceIndex + 1) / totalSentences,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1B7F4E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonInfoCard(LessionEntity lesson, dynamic exercise) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7F4E), Color(0xFF0D6B3D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7F4E).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.record_voice_over,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.speakingLessonLanguage(exercise.national),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceCard(String sentence) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1B7F4E), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.volume_up_rounded,
            color: Color(0xFF1B7F4E),
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.speakingLessonReadPrompt,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            sentence,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecognitionResult() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hearing, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                l10n.speakingLessonYouSaid,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _recognizedText,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF2D3748),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicrophoneButton(String targetText) {
    return GestureDetector(
      onTap: () => _toggleRecording(targetText),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: _isRecording
                    ? [const Color(0xFFE53E3E), const Color(0xFFC53030)]
                    : [const Color(0xFF1B7F4E), const Color(0xFF0D6B3D)],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (_isRecording
                              ? const Color(0xFFE53E3E)
                              : const Color(0xFF1B7F4E))
                          .withOpacity(0.4),
                  blurRadius: 20 + (_pulseController.value * 10),
                  spreadRadius: _isRecording ? 5 : 2,
                ),
              ],
            ),
            child: Icon(
              _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
              color: Colors.white,
              size: 48,
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackPopup(LessionEntity lesson, String sentence) {
    final isPassed = _accuracy >= 50;

    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isPassed ? Colors.green[50] : Colors.orange[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPassed ? Icons.check_circle : Icons.info,
                  size: 64,
                  color: isPassed ? Colors.green : Colors.orange,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '${_accuracy.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green : Colors.orange,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isPassed ? l10n.speakingLessonFeedbackExcellent : l10n.speakingLessonFeedbackImprove,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),

              const SizedBox(height: 16),

              if (_results.isNotEmpty && _results.last.mistakes.isNotEmpty) ...[
                Text(
                  l10n.speakingLessonFeedbackMistakes,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _results.last.mistakes.map((word) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Text(
                        word,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
              ],

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showFeedback = false;
                          _recognizedText = '';
                        });
                      },
                      icon: const Icon(Icons.replay),
                      label: Text(l10n.speakingLessonFeedbackRetry),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1B7F4E),
                        side: const BorderSide(
                          color: Color(0xFF1B7F4E),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (isPassed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _nextSentence(lesson),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(l10n.speakingLessonFeedbackContinue),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B7F4E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeakingResult {
  final String targetText;
  final String recognizedText;
  final double accuracy;
  final List<String> mistakes;

  SpeakingResult({
    required this.targetText,
    required this.recognizedText,
    required this.accuracy,
    required this.mistakes,
  });
}
