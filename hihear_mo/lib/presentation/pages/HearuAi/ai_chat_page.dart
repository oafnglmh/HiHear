import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/blocs/ai/ai_chat_cubit.dart';
import 'package:hihear_mo/presentation/blocs/lesson/lesson_bloc.dart';
import 'package:hihear_mo/presentation/painter/lotus_pattern_painter.dart';
import 'package:hihear_mo/presentation/painter/ripple_painter.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

enum RobotState { idle, listening, thinking, speaking }

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isSpeechInitialized = false;

  late final l10n = AppLocalizations.of(context)!;

  late AnimationController _lotusController;
  late AnimationController _rippleController;
  late AnimationController _floatingController;
  late AnimationController _idleController;
  late AnimationController _listeningController;
  late AnimationController _thinkingController;
  late AnimationController _speakingController;

  late Animation<double> _idleAnimation;
  late Animation<double> _listeningAnimation;
  late Animation<double> _thinkingRotation;
  late Animation<double> _speakingAnimation;

  RobotState _robotState = RobotState.idle;
  bool _isListening = false;
  bool _isAiSpeaking = false;
  String _userText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initSpeech();
    _initTts();
    _initAnimations();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _forceCleanupAll();
    } else if (state == AppLifecycleState.resumed) {
      _resetSpeechState();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resetSpeechState();
  }

  void _initSpeech() {
    _speech = stt.SpeechToText();
    _isSpeechInitialized = false;
  }

  void _initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setLanguage("vi-VN");
    await _flutterTts.setSpeechRate(0.7);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.awaitSpeakCompletion(true);

    _flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          _isAiSpeaking = false;
          _robotState = RobotState.idle;
        });
      }
    });

    _flutterTts.setErrorHandler((msg) {
      if (mounted) {
        setState(() {
          _isAiSpeaking = false;
          _robotState = RobotState.idle;
        });
      }
    });
  }

  void _initAnimations() {
    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _idleAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _idleController, curve: Curves.easeInOut),
    );

    _listeningController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _listeningAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _listeningController, curve: Curves.easeInOut),
    );

    _thinkingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _thinkingRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _thinkingController, curve: Curves.linear),
    );

    _speakingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _speakingAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _speakingController, curve: Curves.easeInOut),
    );
  }

  void _resetSpeechState() {

    try {
      if (_isListening) {
        _speech.cancel();
        _speech.stop();
      }

      if (_isAiSpeaking) {
        _flutterTts.stop();
      }

      _isSpeechInitialized = false;

      if (mounted) {
        setState(() {
          _isListening = false;
          _isAiSpeaking = false;
          _robotState = RobotState.idle;
          _userText = '';
        });
      }
    } catch (e) {
      debugPrint('Error in _resetSpeechState: $e');
    }
  }

  void _forceCleanupAll() {

    try {
      _speech.cancel();
      _speech.stop();
      _flutterTts.stop();
      _isSpeechInitialized = false;
    } catch (e) {
      debugPrint('Error in _forceCleanupAll: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _forceCleanupAll();

    _lotusController.dispose();
    _rippleController.dispose();
    _floatingController.dispose();
    _idleController.dispose();
    _listeningController.dispose();
    _thinkingController.dispose();
    _speakingController.dispose();

    super.dispose();
  }

  String _prepareTextForTts(String text) {
    return text
        .replaceAll('*', '')
        .replaceAll('_', '')
        .replaceAll('~', '')
        .replaceAll(RegExp(r'[\n\r]+'), ', ');
  }

  Future<void> _speakResponse(String text) async {
    setState(() {
      _isAiSpeaking = true;
      _robotState = RobotState.speaking;
    });
    final cleanedText = _prepareTextForTts(text);
    await _flutterTts.speak(cleanedText);
  }

  Future<bool> _checkMicrophonePermission() async {
    try {
      bool hasPermission = await _speech.hasPermission;
      if (!hasPermission) {
        debugPrint('No microphone permission');
        if (mounted) {
          _showError('Cần cấp quyền microphone trong Cài đặt');
        }
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Error checking permission: $e');
      return false;
    }
  }

  Future<void> _startListening() async {
    try {
      debugPrint('🎤 Starting listening process...');

      if (!await _checkMicrophonePermission()) {
        return;
      }

      await _speech.cancel();
      await _speech.stop();

      if (_isAiSpeaking) {
        await _flutterTts.stop();
        if (mounted) {
          setState(() => _isAiSpeaking = false);
        }
      }

      await Future.delayed(const Duration(milliseconds: 200));
      _isSpeechInitialized = false;

      bool available = await _speech.initialize(
        onStatus: (status) {

          if (status == 'done' || status == 'notListening') {
            if (_isListening && mounted) {
              setState(() {
                _isListening = false;
                _robotState = RobotState.thinking;
              });

              if (_userText.isNotEmpty) {
                _sendMessage();
              } else {
                if (mounted) {
                  setState(() => _robotState = RobotState.idle);
                }
              }
            }
          }
        },
        onError: (error) {

          if (mounted) {
            setState(() {
              _isListening = false;
              _robotState = RobotState.idle;
            });
            _showError('Lỗi nhận diện: ${error.errorMsg}');
          }

          _isSpeechInitialized = false;
        },
      );

      if (!available) {
        _isSpeechInitialized = false;
        if (mounted) {
          _showError(l10n.aiChatErrorSpeechNotAvailable);
        }
        return;
      }

      _isSpeechInitialized = true;
      if (mounted) {
        setState(() {
          _isListening = true;
          _robotState = RobotState.listening;
          _userText = '';
        });
      }

      await _speech.listen(
        onResult: (result) {
          if (mounted && _isListening) {
            setState(() => _userText = result.recognizedWords);
            debugPrint('📝 Recognized: $_userText');
          }
        },
        localeId: 'vi_VN',
        listenMode: stt.ListenMode.confirmation,
        pauseFor: const Duration(seconds: 3),
        listenFor: const Duration(seconds: 30),
        cancelOnError: true,
      );

      Future.delayed(const Duration(seconds: 35), () {
        if (mounted && _isListening) {
          _stopListening();
        }
      });
    } catch (e, stackTrace) {
      _isSpeechInitialized = false;

      if (mounted) {
        setState(() {
          _isListening = false;
          _robotState = RobotState.idle;
        });
        _showError('Không thể khởi động mic: ${e.toString()}');
      }
    }
  }

  Future<void> _stopListening() async {
    if (!_isListening) return;
    try {
      await _speech.stop();

      if (mounted) {
        setState(() {
          _isListening = false;
          _robotState = _userText.isNotEmpty
              ? RobotState.thinking
              : RobotState.idle;
        });

        if (_userText.isNotEmpty) {
          _sendMessage();
        }
      }
    } catch (e) {
      debugPrint('Error stopping speech: $e');
    }
  }

  void _sendMessage() {
    if (_userText.trim().isEmpty) {
      if (mounted) {
        setState(() => _robotState = RobotState.idle);
      }
      return;
    }

    context.read<AiChatCubit>().sendMessage(_userText);

    if (mounted) {
      setState(() => _userText = '');
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.vietnamRed,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppPadding.large),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A5C36),
                  Color(0xFF1B7F4E),
                  Color(0xFF0D6B3D),
                  Color(0xFF0D4D2D),
                ],
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _lotusController,
            builder: (context, child) {
              return CustomPaint(
                painter: LotusPatternPainter(
                  animationValue: _lotusController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return CustomPaint(
                painter: RipplePainter(animationValue: _rippleController.value),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  _buildRobotAvatar(),

                  const SizedBox(height: 24),

                  _buildStatusBadge(),

                  const SizedBox(height: 32),
                  Expanded(
                    child: BlocConsumer<AiChatCubit, AiChatState>(
                      listener: (context, state) {
                        if (state is AiChatLoadedWithAction) {
                          _handleAiAction(state.actionType, state.actionData);

                          final lastMessage = state.messages.last;
                          if (!lastMessage.isUser) {
                            _speakResponse(lastMessage.text);
                          }
                        } else if (state is AiChatLoaded) {
                          final lastMessage = state.messages.last;
                          if (!lastMessage.isUser) {
                            _speakResponse(lastMessage.text);
                          }
                        } else if (state is AiChatError) {
                          setState(() => _robotState = RobotState.idle);
                          _showError(state.error);
                        } else if (state is AiChatLoading) {
                          setState(() => _robotState = RobotState.thinking);
                        }
                      },
                      builder: (context, state) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),

                  if (_isListening || _userText.isNotEmpty)
                    _buildListeningCard(),

                  const SizedBox(height: 24),

                  _buildMicButton(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAiAction(AiActionType actionType, Map<String, dynamic>? data) {
    print('🎯 Executing action: $actionType');
    print('📦 Action data: $data');

    switch (actionType) {
      case AiActionType.navigateToNextLesson:
        _navigateToNextLesson();
        break;

      case AiActionType.changeUserName:
        final newName = data?['newName'] as String?;
        if (newName != null) {
          _showChangeNameDialog(newName);
        }
        break;

      case AiActionType.none:
        break;
    }
  }

  void _navigateToNextLesson() async {
    await _cleanupBeforeNavigate();
    final lessonBloc = context.read<LessonBloc>();

    lessonBloc.add(const LessonEvent.loadNextLesson());

    final state = await lessonBloc.stream.firstWhere(
      (state) =>
          state.maybeWhen(nextLessonLoaded: (_) => true, orElse: () => false),
    );

    state.when(
      initial: () {},
      loading: () {},
      error: (message) {
        debugPrint('Load next lesson error: $message');
      },
      nextLessonLoaded: (lesson) {
        if (lesson.category?.contains('Ngữ pháp') == true) {
          context.go('/grammar/${lesson.id}');
        } else if (lesson.category?.contains('Từ vựng') == true) {
          context.go('/vocab/${lesson.id}');
        }
      }, data: (List<LessionEntity> lessons) {  },
    );
  }

  Future<void> _cleanupBeforeNavigate() async {
    if (_isListening) {
      await _speech.cancel();
      await _speech.stop();
      setState(() {
        _isListening = false;
        _robotState = RobotState.idle;
      });
    }

    if (_isAiSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isAiSpeaking = false;
      });
    }
  }

  void _showChangeNameDialog(String newName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.98)],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: const Color(0xFFD4AF37), width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),

            Text(
              "Tên",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D4D2D),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              newName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                ),
              ),
              child: Text(
                newName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D4D2D),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFD4AF37)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Hủy",
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _confirmChangeName(newName);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Xác nhận",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmChangeName(String newName) async {
    UserShare().name = newName;

    _showError('Đã đổi tên thành công!');
  }

  Widget _buildRobotAvatar() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * math.pi * 2) * 8,
          ),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _idleController,
              _listeningController,
              _thinkingController,
              _speakingController,
            ]),
            builder: (context, child) {
              Widget robotWidget;

              switch (_robotState) {
                case RobotState.idle:
                  robotWidget = _buildRobotBody(color: const Color(0xFFD4AF37));
                  break;

                case RobotState.listening:
                  robotWidget = Transform.scale(
                    scale: _listeningAnimation.value,
                    child: _buildRobotBody(
                      color: AppColors.vietnamRed,
                      glowColor: AppColors.vietnamRed,
                    ),
                  );
                  break;

                case RobotState.thinking:
                  robotWidget = RotationTransition(
                    turns: _thinkingRotation,
                    child: _buildRobotBody(
                      color: Colors.orange,
                      showThinkingDots: true,
                    ),
                  );
                  break;

                case RobotState.speaking:
                  robotWidget = Transform.scale(
                    scale: _speakingAnimation.value,
                    child: _buildRobotBody(
                      color: AppColors.bamboo1,
                      glowColor: AppColors.bamboo1,
                    ),
                  );
                  break;
              }

              return robotWidget;
            },
          ),
        );
      },
    );
  }

  Widget _buildRobotBody({
    Color? color,
    Color? glowColor,
    bool showThinkingDots = false,
  }) {
    final robotColor = color ?? const Color(0xFFD4AF37);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: robotColor.withOpacity(0.5), width: 3),
        boxShadow: [
          BoxShadow(
            color: (glowColor ?? robotColor).withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [robotColor.withOpacity(0.3), Colors.transparent],
              ),
              shape: BoxShape.circle,
            ),
          ),

          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [robotColor.withOpacity(0.9), robotColor],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildEye(),
                    const SizedBox(width: 20),
                    _buildEye(),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: 40,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),

          if (showThinkingDots)
            Positioned(
              top: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildThinkingDot(0),
                  const SizedBox(width: 5),
                  _buildThinkingDot(100),
                  const SizedBox(width: 5),
                  _buildThinkingDot(200),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEye() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF2D5016),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildThinkingDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5 + value * 0.5),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        Future.delayed(Duration(milliseconds: delay), () {
          if (mounted && _robotState == RobotState.thinking) {
            setState(() {});
          }
        });
      },
    );
  }

  Widget _buildStatusBadge() {
    String statusText;
    Color badgeColor;

    switch (_robotState) {
      case RobotState.idle:
        statusText = l10n.aiChatReadyToChat;
        badgeColor = const Color(0xFFD4AF37);
        break;
      case RobotState.listening:
        statusText = l10n.aiChatListening;
        badgeColor = AppColors.vietnamRed;
        break;
      case RobotState.thinking:
        statusText = l10n.aiChatThinking;
        badgeColor = Colors.orange;
        break;
      case RobotState.speaking:
        statusText = l10n.aiChatSpeaking;
        badgeColor = AppColors.bamboo1;
        break;
    }

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * math.pi * 2 + 1) * 4,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [badgeColor, badgeColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: badgeColor.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              statusText,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListeningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.vietnamRed.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.vietnamRed.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (_isListening)
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              if (_isListening) const SizedBox(width: 12),
              Text(
                _isListening ? l10n.aiChatListeningNow : l10n.aiChatRecognized,
                style: const TextStyle(
                  color: AppColors.vietnamRed,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _userText.isEmpty ? l10n.aiChatSaySomething : _userText,
            style: TextStyle(
              color: _userText.isEmpty
                  ? const Color(0xFF2D5016).withOpacity(0.5)
                  : const Color(0xFF2D5016),
              fontSize: 16,
              fontStyle: _userText.isEmpty
                  ? FontStyle.italic
                  : FontStyle.normal,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: _isListening ? _stopListening : _startListening,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (value * 0.2),
            child: Opacity(
              opacity: value,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isListening
                        ? [AppColors.vietnamRed, const Color(0xFFFD0000)]
                        : [const Color(0xFFD4AF37), const Color(0xFFB8941E)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isListening
                                  ? AppColors.vietnamRed
                                  : const Color(0xFFD4AF37))
                              .withOpacity(0.5),
                      blurRadius: 25,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  _isListening ? Icons.stop_rounded : Icons.mic_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
