import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/data/models/phoneme.dart';
import 'package:hihear_mo/data/repositories/phoneme_repository.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({super.key});

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(Phoneme phoneme) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(phoneme.tts);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(phoneme.example);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Widget _buildPhonemeGrid(List<Phoneme> phonemes) {
    return GridView.builder(
      itemCount: phonemes.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        final phoneme = phonemes[index];
        return GestureDetector(
          onTap: () => _speak(phoneme),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF8B271)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    phoneme.symbol,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phoneme.example,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 22, 20, 29),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cùng học phát âm tiếng Anh!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Tập nghe và học phát âm các âm trong tiếng Anh",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/speaking');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                    backgroundColor: AppColors.background,
                  ),
                  child: const Text(
                    "BẮT ĐẦU BÀI HỌC",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: Color.fromARGB(255, 248, 178, 113)),
              const SizedBox(height: 8),
              const Text("Nguyên âm"),
              const SizedBox(height: 12),
              _buildPhonemeGrid(PhonemeRepository.vowels),
              const Divider(color: Color.fromARGB(255, 248, 178, 113)),
              const Text("Phụ âm"),
              const SizedBox(height: 12),
              _buildPhonemeGrid(PhonemeRepository.consonants),
            ],
          ),
        ),
      ),
    );
  }
}
