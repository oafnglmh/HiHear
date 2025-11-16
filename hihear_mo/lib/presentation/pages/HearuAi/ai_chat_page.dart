import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/blocs/ai/ai_chat_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_text_styles.dart';

// ================= ROBOT STATE ENUM =================
enum RobotState {
  idle,      // Đứng yên, nhẹ nhàng
  listening, // Đang lắng nghe
  thinking,  // Đang suy nghĩ (loading)
  speaking,  // Đang nói
}

// ================= AI CHAT PAGE =================
class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage>
    with TickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
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
    // Idle animation - nhẹ nhàng lên xuống
    _idleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _idleAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _idleController, curve: Curves.easeInOut),
    );

    // Listening animation - pulse nhanh
    _listeningController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);
    
    _listeningAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _listeningController, curve: Curves.easeInOut),
    );

    // Thinking animation - xoay tròn
    _thinkingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    
    _thinkingRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _thinkingController, curve: Curves.linear),
    );

    // Speaking animation - nhấp nháy
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
        _showError('Lỗi nhận diện giọng nói: ${error.errorMsg}');
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
        children: [
          const _GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: AppPadding.large),
                
                _buildRobotAvatar(),
                
                SizedBox(height: AppPadding.medium),
                
                _buildStatusText(),
                
                SizedBox(height: AppPadding.large),
                
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
                      if (messages.isEmpty) return _buildEmptyState();
                      return SizedBox();
                    },
                  ),
                ),
                
                if (_isListening || _userText.isNotEmpty) _buildListeningBar(),
                
                SizedBox(height: AppPadding.large),
                
                _buildMicButton(),
                
                SizedBox(height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRobotAvatar() {
    return AnimatedBuilder(
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
            robotWidget = Transform.translate(
              offset: Offset(0, _idleAnimation.value),
              child: _buildRobotBody(),
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
                showSoundWaves: true,
              ),
            );
            break;
        }
        
        return robotWidget;
      },
    );
  }

  Widget _buildRobotBody({
    Color? color,
    Color? glowColor,
    bool showThinkingDots = false,
    bool showSoundWaves = false,
  }) {
    final robotColor = color ?? AppColors.goldDark;
    
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            robotColor.withOpacity(0.8),
            robotColor,
          ],
        ),
        boxShadow: glowColor != null
            ? [
                BoxShadow(
                  color: glowColor.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Robot face
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Eyes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEye(),
                  SizedBox(width: 20),
                  _buildEye(),
                ],
              ),
              SizedBox(height: 15),
              // Mouth
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
          
          // Thinking dots
          if (showThinkingDots)
            Positioned(
              top: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildThinkingDot(0),
                  SizedBox(width: 5),
                  _buildThinkingDot(100),
                  SizedBox(width: 5),
                  _buildThinkingDot(200),
                ],
              ),
            ),
          
          // Sound waves
          if (showSoundWaves)
            ...[
              Positioned(
                left: -20,
                child: _buildSoundWave(delay: 0),
              ),
              Positioned(
                right: -20,
                child: _buildSoundWave(delay: 200),
              ),
            ],
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
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildThinkingDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600),
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

  Widget _buildSoundWave({required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Container(
          width: 15,
          height: 30 * value,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7 * (1 - value)),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
      onEnd: () {
        Future.delayed(Duration(milliseconds: delay), () {
          if (mounted && _robotState == RobotState.speaking) {
            setState(() {});
          }
        });
      },
    );
  }

  Widget _buildStatusText() {
    String statusText;
    Color statusColor;
    
    switch (_robotState) {
      case RobotState.idle:
        statusText = 'Sẵn sàng trò chuyện';
        statusColor = Colors.white70;
        break;
      case RobotState.listening:
        statusText = '👂 Đang lắng nghe...';
        statusColor = Colors.white;
        break;
      case RobotState.thinking:
        statusText = '🤔 Đang suy nghĩ...';
        statusColor = Colors.white;
        break;
      case RobotState.speaking:
        statusText = '🗣️ Đang trả lời...';
        statusColor = Colors.white;
        break;
    }
    
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: Text(
        statusText,
        key: ValueKey(statusText),
        style: TextStyle(
          color: statusColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.xxLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chào mừng bạn đến với Hearu! 🇻🇳',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppPadding.large),
            Text(
              'Tôi là trợ lý AI sẽ giúp bạn học tiếng Việt và khám phá văn hóa Việt Nam',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppPadding.xLarge),
            Container(
              padding: EdgeInsets.all(AppPadding.large),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppRadius.large),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '💡 Nhấn vào nút microphone bên dưới để bắt đầu trò chuyện',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildChatList(List<ChatMessage> messages) {
  //   return ListView.builder(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: AppPadding.large,
  //       vertical: AppPadding.medium,
  //     ),
  //     reverse: true,
  //     itemCount: messages.length,
  //     itemBuilder: (context, index) {
  //       final message = messages[messages.length - 1 - index];
  //       return _buildMessageBubble(message);
  //     },
  //   );
  // }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: AppPadding.medium),
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.large,
          vertical: AppPadding.medium,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: message.isUser
              ? LinearGradient(
                  colors: [AppColors.goldLight, AppColors.goldDark],
                )
              : null,
          color: message.isUser ? null : Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.large),
            topRight: Radius.circular(AppRadius.large),
            bottomLeft: Radius.circular(message.isUser ? AppRadius.large : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : AppRadius.large),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.isUser ? '👤' : '🤖',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: AppPadding.small),
                Text(
                  message.isUser ? 'Bạn' : 'Hearu',
                  style: TextStyle(
                    color: message.isUser
                        ? Colors.white.withOpacity(0.8)
                        : AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppPadding.small),
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : AppColors.textPrimary,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListeningBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppPadding.large),
      padding: EdgeInsets.all(AppPadding.large),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: AppColors.vietnamRed.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.vietnamRed.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 5),
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
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              if (_isListening) SizedBox(width: AppPadding.small),
              Text(
                _isListening ? '🎤 Đang nghe...' : '✓ Đã nhận',
                style: TextStyle(
                  color: AppColors.vietnamRed,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppPadding.small),
          Text(
            _userText.isEmpty ? 'Hãy nói điều gì đó...' : _userText,
            style: TextStyle(
              color: _userText.isEmpty
                  ? AppColors.textSecondary.withOpacity(0.5)
                  : AppColors.textPrimary,
              fontSize: 16,
              fontStyle: _userText.isEmpty ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: _isListening ? _stopListening : _startListening,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isListening
                ? [AppColors.vietnamRed, AppColors.vietnamRedLight]
                : [AppColors.goldLight, AppColors.goldDark],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (_isListening ? AppColors.vietnamRed : AppColors.goldDark)
                  .withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          _isListening ? Icons.stop_rounded : Icons.mic_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}

// ================= BACKGROUND =================
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.bamboo1, AppColors.bamboo2, AppColors.bamboo3],
        ),
      ),
    );
  }
}