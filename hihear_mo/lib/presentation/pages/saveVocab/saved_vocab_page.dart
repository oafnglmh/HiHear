import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/presentation/painter/bamboo_painter.dart';

class SavedVocabPage extends StatefulWidget {
  const SavedVocabPage({super.key});

  @override
  State<SavedVocabPage> createState() => _SavedVocabPageState();
}

class _SavedVocabPageState extends State<SavedVocabPage>
    with TickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _headerController;
  late AnimationController _bambooController;

  final List<Map<String, String>> _savedVocab = [
    {'en': 'apple', 'vi': 'quả táo', 'category': 'Thức ăn', 'emoji': '🍎'},
    {'en': 'book', 'vi': 'quyển sách', 'category': 'Học tập', 'emoji': '📚'},
    {'en': 'computer', 'vi': 'máy tính', 'category': 'Công nghệ', 'emoji': '💻'},
    {'en': 'friend', 'vi': 'người bạn', 'category': 'Xã hội', 'emoji': '👥'},
    {'en': 'music', 'vi': 'âm nhạc', 'category': 'Nghệ thuật', 'emoji': '🎵'},
    {'en': 'school', 'vi': 'trường học', 'category': 'Học tập', 'emoji': '🏫'},
    {'en': 'teacher', 'vi': 'giáo viên', 'category': 'Học tập', 'emoji': '👨‍🏫'},
    {'en': 'beautiful', 'vi': 'đẹp', 'category': 'Tính từ', 'emoji': '✨'},
  ];

  List<Map<String, String>> _filteredVocab = [];
  String _selectedCategory = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _filteredVocab = List.from(_savedVocab);
    _searchController.addListener(_onSearchChanged);
    
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tts.stop();
    _searchController.dispose();
    _headerController.dispose();
    _bambooController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredVocab = _savedVocab.where((vocab) {
        final en = vocab['en']!.toLowerCase();
        final vi = vocab['vi']!.toLowerCase();
        final matchesSearch = en.contains(query) || vi.contains(query);
        final matchesCategory = _selectedCategory == 'Tất cả' ||
            vocab['category'] == _selectedCategory;
        return matchesSearch && matchesCategory;
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
      body: Stack(
        children: [
          // Background gradient - màu tre xanh
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4A7C2C),
                  Color(0xFF5E9A3A),
                  Color(0xFF3D6624),
                ],
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _bambooController,
            builder: (context, child) {
              return CustomPaint(
                painter: BambooPainter(
                  animationValue: _bambooController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildSearchBar(),
                  _buildCategoryFilter(),
                  _buildStatsBar(),
                  _buildVocabGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _headerController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _headerController,
          curve: Curves.easeOut,
        )),
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFD4AF37).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Từ đã lưu",
                          style: TextStyle(
                            color: Color(0xFF2D5016),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_savedVocab.length} từ vựng",
                      style: TextStyle(
                        color: const Color(0xFF2D5016).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Color(0xFF2D5016)),
          decoration: InputDecoration(
            hintText: 'Tìm từ vựng... 🔍',
            hintStyle: TextStyle(
              color: const Color(0xFF2D5016).withOpacity(0.5),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFD4AF37),
              size: 24,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: const Color(0xFF2D5016).withOpacity(0.5),
                    ),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white.withOpacity(0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: const Color(0xFFD4AF37).withOpacity(0.3),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFD4AF37),
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'name': 'Tất cả', 'emoji': '📚'},
      {'name': 'Thức ăn', 'emoji': '🍎'},
      {'name': 'Học tập', 'emoji': '📖'},
      {'name': 'Công nghệ', 'emoji': '💻'},
      {'name': 'Xã hội', 'emoji': '👥'},
      {'name': 'Nghệ thuật', 'emoji': '🎨'},
    ];
    
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category['name'] == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category['name']!;
                  _onSearchChanged();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                        )
                      : null,
                  color: isSelected ? null : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFD4AF37)
                        : const Color(0xFFD4AF37).withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  children: [
                    Text(
                      category['emoji']!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category['name']!,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF2D5016),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            '📚',
            _filteredVocab.length.toString(),
            "Từ hiển thị",
            const Color(0xFFD4AF37),
          ),
          Container(
            width: 2,
            height: 40,
            color: const Color(0xFFD4AF37).withOpacity(0.3),
          ),
          _buildStatItem(
            '🔥',
            "7",
            "Ngày streak",
            const Color(0xFFDA291C),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label, Color color) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF2D5016).withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabGrid() {
    if (_filteredVocab.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFD4AF37).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔍', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              const Text(
                "Không tìm thấy từ nào",
                style: TextStyle(
                  color: Color(0xFF2D5016),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Thử tìm kiếm với từ khóa khác",
                style: TextStyle(
                  color: const Color(0xFF2D5016).withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _filteredVocab.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 50)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: Opacity(
                  opacity: value,
                  child: _buildFlipCard(_filteredVocab[index], index),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFlipCard(Map<String, String> vocab, int index) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      speed: 500,
      front: _buildCardFace(
        title: vocab['en']!,
        subtitle: "Nhấn để xem nghĩa",
        category: vocab['category']!,
        emoji: vocab['emoji']!,
        icon: Icons.volume_up_rounded,
        onIconPressed: () => _speak(vocab['en']!),
        index: index,
      ),
      back: _buildCardFace(
        title: vocab['vi']!,
        subtitle: vocab['en'],
        category: vocab['category']!,
        emoji: vocab['emoji']!,
        isBack: true,
        index: index,
      ),
    );
  }

  Widget _buildCardFace({
    required String title,
    String? subtitle,
    required String category,
    required String emoji,
    IconData? icon,
    VoidCallback? onIconPressed,
    bool isBack = false,
    required int index,
  }) {
    final colors = _getCardColors(index);
    
    return Container(
      decoration: BoxDecoration(
        gradient: isBack
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              )
            : null,
        color: isBack ? null : Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isBack
              ? colors[0].withOpacity(0.5)
              : const Color(0xFFD4AF37).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isBack
                ? colors[0].withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circle
          if (!isBack)
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      colors[0].withOpacity(0.1),
                      colors[1].withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isBack
                            ? Colors.white.withOpacity(0.2)
                            : colors[0].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isBack ? Colors.white : colors[0],
                        ),
                      ),
                    ),
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: colors,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              icon,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: onIconPressed,
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isBack ? Colors.white : const Color(0xFF2D5016),
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: isBack
                                ? Colors.white.withOpacity(0.8)
                                : const Color(0xFF2D5016).withOpacity(0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getCardColors(int index) {
    final colorSets = [
      [const Color(0xFFDA291C), const Color(0xFFFD0000)],
      [const Color(0xFFD4AF37), const Color(0xFFB8941E)],
      [const Color(0xFF4A7C2C), const Color(0xFF5E9A3A)],
      [const Color(0xFFFF6B35), const Color(0xFFFF8C50)],
      [const Color(0xFF667eea), const Color(0xFF764ba2)],
    ];
    return colorSets[index % colorSets.length];
  }
}