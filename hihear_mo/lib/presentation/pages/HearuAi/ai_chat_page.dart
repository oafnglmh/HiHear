import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/blocs/ai/ai_chat_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_text_styles.dart';

// ================= AI CHAT PAGE =================
class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  late AnimationController _micController;
  late Animation<double> _pulseAnimation;

  bool _isListening = false;
  bool _isAiSpeaking = false;
  String _userText = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initTts();
    _initAnimation();
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
      setState(() => _isAiSpeaking = false);
    });

    _flutterTts.setErrorHandler((msg) {
      debugPrint("TTS Error: $msg");
      setState(() => _isAiSpeaking = false);
    });
  }

  String _prepareTextForTts(String text) {
    return text
        .replaceAll('*', '')
        .replaceAll('_', '')
        .replaceAll('~', '')
        .replaceAll(RegExp(r'[\n\r]+'), ', ');
  }

  Future<void> _speakResponse(String text) async {
    setState(() => _isAiSpeaking = true);
    final cleanedText = _prepareTextForTts(text);
    await _flutterTts.speak(cleanedText);
  }

  void _initAnimation() {
    _micController = AnimationController(
      vsync: this,
      duration: AppDuration.medium,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _micController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _micController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _startListening() async {
    if (_isAiSpeaking) {
      await _flutterTts.stop();
      setState(() => _isAiSpeaking = false);
    }

    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done') {
          setState(() => _isListening = false);
          if (_userText.isNotEmpty) _sendMessage();
        }
      },
      onError: (error) {
        setState(() => _isListening = false);
        _showError('Lỗi nhận diện giọng nói: ${error.errorMsg}');
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
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
    setState(() => _isListening = false);
    if (_userText.isNotEmpty) _sendMessage();
  }

  void _sendMessage() {
    if (_userText.trim().isEmpty) return;
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
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
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
                Expanded(
                  child: BlocConsumer<AiChatCubit, AiChatState>(
                    listener: (context, state) {
                      if (state is AiChatLoaded) {
                        final lastMessage = state.messages.last;
                        if (!lastMessage.isUser)
                          _speakResponse(lastMessage.text);
                      } else if (state is AiChatError) {
                        _showError(state.error);
                      }
                    },
                    builder: (context, state) {
                      final messages = state.messages;
                      if (messages.isEmpty) return _buildEmptyState();
                      return _buildChatList(messages);
                    },
                  ),
                ),
                if (_isListening || _userText.isNotEmpty) _buildListeningBar(),

                SizedBox(height: 170),
              ],
            ),
          ),
          Positioned(
            bottom: 130, // đẩy lên trên nav bar
            left: 0,
            right: 0,
            child: Center(child: _buildMicButton()),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🇻🇳', style: TextStyle(fontSize: 80)),
          SizedBox(height: AppPadding.large),
          Text(
            'Chào mừng bạn!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppPadding.large),
          Text(
            'Nhấn vào mic để nói chuyện với AI về văn hóa và tiếng Việt',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(List<ChatMessage> messages) {
    return ListView.builder(
      padding: EdgeInsets.all(AppPadding.large),
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: AppPadding.medium),
        padding: EdgeInsets.all(AppPadding.large),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: message.isUser
              ? const LinearGradient(
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        ? Colors.white70
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
      margin: EdgeInsets.all(AppPadding.large),
      padding: EdgeInsets.all(AppPadding.large),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: AppColors.vietnamRed.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_isListening)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              if (_isListening) SizedBox(width: AppPadding.small),
              Text(
                _isListening ? 'Đang nghe...' : 'Đã nhận:',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
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
              fontStyle: _userText.isEmpty
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicButton() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isListening ? _pulseAnimation.value : 1.0,
          child: GestureDetector(
            onTap: _isListening ? _stopListening : _startListening,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isListening
                      ? [AppColors.vietnamRed, AppColors.vietnamRedLight]
                      : [AppColors.goldLight, AppColors.goldDark],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isListening ? Icons.stop : Icons.mic,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        );
      },
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
