import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/blocs/ai/ai_chat_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

enum RobotState {
  idle,
  listening,
  thinking,
  speaking,
}

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> with TickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  
  // Animation controllers cho background effects
  late AnimationController _lotusController;
  late AnimationController _rippleController;
  late AnimationController _floatingController;
  
  // Animation controllers cho robot states
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
    _initSpeech();
    _initTts();
    _initAnimations();
  }

  void _initSpeech() {
    _speech = stt.SpeechToText();
  }

  void _initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setLanguage("vi-VN");
    await _flutterTts.setSpeechRate(0.7);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.awaitSpeakCompletion(true);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isAiSpeaking = false;
        _robotState = RobotState.idle;
      });
    });

    _flutterTts.setErrorHandler((msg) {
      debugPrint("TTS Error: $msg");
      setState(() {
        _isAiSpeaking = false;
        _robotState = RobotState.idle;
      });
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
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _idleAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _idleController, curve: Curves.easeInOut),
    );

    _listeningController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);
    
    _listeningAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _listeningController, curve: Curves.easeInOut),
    );

    _thinkingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    
    _thinkingRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _thinkingController, curve: Curves.linear),
    );

    _speakingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    
    _speakingAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _speakingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _lotusController.dispose();
    _rippleController.dispose();
    _floatingController.dispose();
    _idleController.dispose();
    _listeningController.dispose();
    _thinkingController.dispose();
    _speakingController.dispose();
    _flutterTts.stop();
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

  Future<void> _startListening() async {
    if (_isAiSpeaking) {
      await _flutterTts.stop();
      setState(() => _isAiSpeaking = false);
    }

    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          setState(() {
            _isListening = false;
            _robotState = RobotState.thinking;
          });
          if (_userText.isNotEmpty) _sendMessage();
        }
      },
      onError: (error) {
        setState(() {
          _isListening = false;
          _robotState = RobotState.idle;
        });
        _showError('Lỗi nhận diện giọng nói');
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _robotState = RobotState.listening;
        _userText = '';
      });

      _speech.listen(
        onResult: (result) {
          setState(() => _userText = result.recognizedWords);
        },
        localeId: 'vi_VN',
      );
    } else {
      _showError('Không thể khởi động nhận diện giọng nói');
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
      _robotState = RobotState.thinking;
    });
  }

  void _sendMessage() {
    if (_userText.trim().isEmpty) {
      setState(() => _robotState = RobotState.idle);
      return;
    }
    context.read<AiChatCubit>().sendMessage(_userText);
    setState(() => _userText = '');
  }

  void _showError(String message) {
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
                painter: RipplePainter(
                  animationValue: _rippleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
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
                        if (state is AiChatLoaded) {
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
                        final messages = state.messages;
                        if (messages.isEmpty) return SizedBox.shrink();
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

  Widget _buildRobotAvatar() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 8),
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
                  robotWidget = _buildRobotBody(
                    color: const Color(0xFFD4AF37),
                  );
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
        border: Border.all(
          color: robotColor.withOpacity(0.5),
          width: 3,
        ),
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
                colors: [
                  robotColor.withOpacity(0.3),
                  Colors.transparent,
                ],
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
                colors: [
                  robotColor.withOpacity(0.9),
                  robotColor,
                ],
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
        statusText = 'Sẵn sàng trò chuyện';
        badgeColor = const Color(0xFFD4AF37);
        break;
      case RobotState.listening:
        statusText = 'Đang lắng nghe...';
        badgeColor = AppColors.vietnamRed;
        break;
      case RobotState.thinking:
        statusText = 'Đang suy nghĩ...';
        badgeColor = Colors.orange;
        break;
      case RobotState.speaking:
        statusText = 'Đang trả lời...';
        badgeColor = AppColors.bamboo1;
        break;
    }
    
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 1) * 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  badgeColor,
                  badgeColor.withOpacity(0.8),
                ],
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
                _isListening ? 'Đang nghe...' : 'Đã nhận',
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
            _userText.isEmpty ? 'Hãy nói điều gì đó...' : _userText,
            style: TextStyle(
              color: _userText.isEmpty
                  ? const Color(0xFF2D5016).withOpacity(0.5)
                  : const Color(0xFF2D5016),
              fontSize: 16,
              fontStyle: _userText.isEmpty ? FontStyle.italic : FontStyle.normal,
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
                      color: (_isListening 
                          ? AppColors.vietnamRed 
                          : const Color(0xFFD4AF37)
                      ).withOpacity(0.5),
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

class LotusPatternPainter extends CustomPainter {
  final double animationValue;

  LotusPatternPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    _drawLotusFlower(
      canvas,
      Offset(size.width - 70, 80 + math.sin(animationValue * math.pi * 2) * 8),
      90,
      0.18 + animationValue * 0.06,
    );

    _drawLotusFlower(
      canvas,
      Offset(70, size.height - 120 + math.cos(animationValue * math.pi * 2) * 10),
      110,
      0.15 + animationValue * 0.04,
    );

    _drawLotusFlower(
      canvas,
      Offset(80, 100 + math.sin(animationValue * math.pi * 2 + 1) * 6),
      70,
      0.12 + animationValue * 0.03,
    );

    _drawLotusLeaf(
      canvas,
      Offset(size.width - 90, size.height - 100 + math.sin(animationValue * math.pi * 2) * 7),
      75,
      0.12 + animationValue * 0.03,
    );

    _drawLotusLeaf(
      canvas,
      Offset(size.width - 120, 140 + math.cos(animationValue * math.pi * 2) * 5),
      55,
      0.1,
    );
  }

  void _drawLotusFlower(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.pink.shade100.withOpacity(opacity);

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + (animationValue * 0.1);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(size * 0.3, -size * 0.5, 0, -size * 0.8);
      path.quadraticBezierTo(-size * 0.3, -size * 0.5, 0, 0);

      canvas.drawPath(path, paint);
      canvas.restore();
    }

    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow.shade300.withOpacity(opacity * 1.5);

    canvas.drawCircle(center, size * 0.15, centerPaint);

    for (int i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final x = center.dx + math.cos(angle) * size * 0.1;
      final y = center.dy + math.sin(angle) * size * 0.1;
      canvas.drawCircle(
        Offset(x, y),
        size * 0.02,
        Paint()..color = Colors.orange.shade200.withOpacity(opacity * 1.2),
      );
    }
  }

  void _drawLotusLeaf(Canvas canvas, Offset center, double size, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF2D7A4F).withOpacity(opacity);

    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy - size * 0.7,
      center.dx + size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx + size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    path.lineTo(center.dx, center.dy);
    
    path.moveTo(center.dx, center.dy - size);
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy - size * 0.7,
      center.dx - size, center.dy,
    );
    path.quadraticBezierTo(
      center.dx - size * 0.9, center.dy + size * 0.7,
      center.dx, center.dy + size,
    );
    path.lineTo(center.dx, center.dy);

    canvas.drawPath(path, paint);

    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFF1B5A37).withOpacity(opacity * 0.8);

    canvas.drawLine(
      Offset(center.dx, center.dy - size),
      Offset(center.dx, center.dy + size),
      veinPaint,
    );

    for (int i = -3; i <= 3; i++) {
      if (i == 0) continue;
      final startY = center.dy + (i * size / 4);
      final endX = center.dx + (size * 0.7);
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(endX, startY + size * 0.1),
        veinPaint..strokeWidth = 1.0,
      );
      canvas.drawLine(
        Offset(center.dx, startY),
        Offset(center.dx - endX, startY + size * 0.1),
        veinPaint,
      );
    }
  }

  @override
  bool shouldRepaint(LotusPatternPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;

  RipplePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.1);

    for (int i = 0; i < 3; i++) {
      final progress = (animationValue + (i * 0.33)) % 1.0;
      final radius = progress * size.width * 0.6;
      final opacity = (1 - progress) * 0.15;

      canvas.drawCircle(
        Offset(size.width / 2, size.height * 0.3),
        radius,
        paint..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}