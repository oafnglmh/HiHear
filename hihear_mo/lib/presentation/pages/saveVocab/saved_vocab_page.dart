import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class SavedVocabPage extends StatefulWidget {
  const SavedVocabPage({super.key});

  @override
  State<SavedVocabPage> createState() => _SavedVocabPageState();
}

class _SavedVocabPageState extends State<SavedVocabPage> {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _savedVocab = [
    {'en': 'apple', 'vi': 'quả táo'},
    {'en': 'book', 'vi': 'quyển sách'},
    {'en': 'computer', 'vi': 'máy tính'},
    {'en': 'friend', 'vi': 'người bạn'},
    {'en': 'music', 'vi': 'âm nhạc'},
    {'en': 'school', 'vi': 'trường học'},
    {'en': 'teacher', 'vi': 'giáo viên'},
  ];

  List<Map<String, String>> _filteredVocab = [];

  @override
  void initState() {
    super.initState();
    _filteredVocab = List.from(_savedVocab);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tts.stop();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredVocab = _savedVocab.where((vocab) {
        final en = vocab['en']!.toLowerCase();
        final vi = vocab['vi']!.toLowerCase();
        return en.contains(query) || vi.contains(query);
      }).toList();
    });
  }

  Future<void> _speak(String word) async {
    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.0);
    await _tts.speak(word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 22, 20, 29),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Từ vựng đã lưu",
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: AppColors.textWhite),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm từ vựng...',
                hintStyle: TextStyle(
                  color: AppColors.textWhite.withOpacity(0.6),
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.textWhite),
                filled: true,
                fillColor: AppColors.textWhite.withOpacity(0.15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.textWhite.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.textWhite.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _filteredVocab.isEmpty
                  ? Center(
                      child: Text(
                        "Không tìm thấy từ nào.",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: _filteredVocab.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemBuilder: (context, index) {
                        final vocab = _filteredVocab[index];
                        return _buildFlipCard(vocab);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlipCard(Map<String, String> vocab) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      speed: 500,
      front: _buildCardFace(
        title: vocab['en']!,
        subtitle: "Nhấn để xem nghĩa",
        icon: Icons.volume_up,
        onIconPressed: () => _speak(vocab['en']!),
      ),
      back: _buildCardFace(
        title: vocab['vi']!,
        subtitle: vocab['en'],
        isBack: true,
      ),
    );
  }

  Widget _buildCardFace({
    required String title,
    String? subtitle,
    IconData? icon,
    VoidCallback? onIconPressed,
    bool isBack = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isBack ? AppColors.gold.withOpacity(0.9) : AppColors.bgWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                IconButton(
                  icon: Icon(icon, color: AppColors.textBlue, size: 28),
                  onPressed: onIconPressed,
                ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isBack ? AppColors.textWhite : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              if (subtitle != null)
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: isBack
                        ? Colors.white70
                        : AppColors.textSecondary.withOpacity(0.7),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
