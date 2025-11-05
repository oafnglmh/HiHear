import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';

class SavedVocabPage extends StatefulWidget {
  final bool isPremium;
  
  const SavedVocabPage({
    super.key,
    this.isPremium = true,
  });

  @override
  State<SavedVocabPage> createState() => _SavedVocabPageState();
}

class _SavedVocabPageState extends State<SavedVocabPage>
    with TickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _shimmerController;
  late AnimationController _headerController;

  final List<Map<String, String>> _savedVocab = [
    {'en': 'apple', 'vi': 'quả táo', 'category': 'Food'},
    {'en': 'book', 'vi': 'quyển sách', 'category': 'Education'},
    {'en': 'computer', 'vi': 'máy tính', 'category': 'Technology'},
    {'en': 'friend', 'vi': 'người bạn', 'category': 'Social'},
    {'en': 'music', 'vi': 'âm nhạc', 'category': 'Art'},
    {'en': 'school', 'vi': 'trường học', 'category': 'Education'},
    {'en': 'teacher', 'vi': 'giáo viên', 'category': 'Education'},
    {'en': 'beautiful', 'vi': 'đẹp', 'category': 'Adjective'},
  ];

  List<Map<String, String>> _filteredVocab = [];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredVocab = List.from(_savedVocab);
    _searchController.addListener(_onSearchChanged);
    
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _tts.stop();
    _searchController.dispose();
    _shimmerController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredVocab = _savedVocab.where((vocab) {
        final en = vocab['en']!.toLowerCase();
        final vi = vocab['vi']!.toLowerCase();
        final matchesSearch = en.contains(query) || vi.contains(query);
        final matchesCategory = _selectedCategory == 'All' ||
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
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.isPremium
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                    const Color(0xFF0f3460),
                  ],
                )
              : null,
          color: widget.isPremium ? null : AppColors.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              if (widget.isPremium) _buildCategoryFilter(),
              _buildStatsBar(),
              Expanded(child: _buildVocabGrid()),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isPremium ? _buildPremiumFAB() : null,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: widget.isPremium
                      ? const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        )
                      : null,
                  color: widget.isPremium ? null : AppColors.textWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: widget.isPremium
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFFD700).withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          )
                        ]
                      : null,
                ),
                child: Icon(
                  Icons.bookmark,
                  color: widget.isPremium ? Colors.white : AppColors.textWhite,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Từ vựng đã lưu",
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.isPremium) ...[
                          const SizedBox(width: 8),
                          _buildPremiumBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_savedVocab.length} từ đã lưu",
                      style: TextStyle(
                        color: AppColors.textWhite.withOpacity(0.6),
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

  Widget _buildPremiumBadge() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xFFFFD700),
                Color(0xFFFFA500),
                Color(0xFFFFD700),
              ],
              stops: [
                _shimmerController.value - 0.3,
                _shimmerController.value,
                _shimmerController.value + 0.3,
              ],
            ),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.4),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 12),
              SizedBox(width: 4),
              Text(
                "PRO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.isPremium
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(color: AppColors.textWhite),
          decoration: InputDecoration(
            hintText: 'Tìm kiếm từ vựng...',
            hintStyle: TextStyle(
              color: AppColors.textWhite.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: widget.isPremium
                  ? const Color(0xFFFFD700)
                  : AppColors.textWhite,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.textWhite.withOpacity(0.7),
                    ),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            filled: true,
            fillColor: AppColors.textWhite.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.isPremium
                    ? const Color(0xFFFFD700).withOpacity(0.2)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.isPremium
                    ? const Color(0xFFFFD700)
                    : AppColors.textWhite.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', 'Food', 'Education', 'Technology', 'Social', 'Art'];
    
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  _onSearchChanged();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        )
                      : null,
                  color: isSelected ? null : AppColors.textWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.textWhite.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textWhite.withOpacity(0.7),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: widget.isPremium
            ? LinearGradient(
                colors: [
                  const Color(0xFFFFD700).withOpacity(0.2),
                  const Color(0xFFFFA500).withOpacity(0.1),
                ],
              )
            : null,
        color: widget.isPremium ? null : AppColors.textWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isPremium
              ? const Color(0xFFFFD700).withOpacity(0.3)
              : AppColors.textWhite.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.library_books, _filteredVocab.length.toString(), "Từ hiển thị"),
          _buildStatItem(Icons.local_fire_department, "7", "Streak"),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: widget.isPremium ? const Color(0xFFFFD700) : AppColors.textWhite,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textWhite.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabGrid() {
    if (_filteredVocab.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: AppColors.textWhite.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              "Không tìm thấy từ nào",
              style: TextStyle(
                color: AppColors.textWhite.withOpacity(0.7),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
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
                scale: value,
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
        icon: Icons.volume_up_rounded,
        onIconPressed: () => _speak(vocab['en']!),
        index: index,
      ),
      back: _buildCardFace(
        title: vocab['vi']!,
        subtitle: vocab['en'],
        category: vocab['category']!,
        isBack: true,
        index: index,
      ),
    );
  }

  Widget _buildCardFace({
    required String title,
    String? subtitle,
    required String category,
    IconData? icon,
    VoidCallback? onIconPressed,
    bool isBack = false,
    required int index,
  }) {
    final colors = _getCardColors(index);
    
    return Container(
      decoration: BoxDecoration(
        gradient: widget.isPremium
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isBack
                    ? [colors[0], colors[1]]
                    : [
                        AppColors.textWhite.withOpacity(0.95),
                        AppColors.textWhite.withOpacity(0.85),
                      ],
              )
            : null,
        color: widget.isPremium
            ? null
            : (isBack ? AppColors.gold.withOpacity(0.9) : AppColors.bgWhite),
        borderRadius: BorderRadius.circular(20),
        border: widget.isPremium
            ? Border.all(
                color: isBack
                    ? Colors.white.withOpacity(0.3)
                    : const Color(0xFFFFD700).withOpacity(0.3),
                width: 1.5,
              )
            : null,
        boxShadow: widget.isPremium
            ? [
                BoxShadow(
                  color: isBack
                      ? colors[0].withOpacity(0.3)
                      : const Color(0xFFFFD700).withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 3),
                ),
              ],
      ),
      child: Stack(
        children: [
          if (widget.isPremium && !isBack)
            AnimatedBuilder(
              animation: _shimmerController,
              builder: (context, child) {
                return Positioned(
                  top: -50,
                  left: -50 + (_shimmerController.value * 250),
                  child: Container(
                    width: 100,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isBack
                        ? Colors.white.withOpacity(0.2)
                        : colors[0].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isBack ? Colors.white : colors[0],
                    ),
                  ),
                ),
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.isPremium
                                ? const Color(0xFFFFD700).withOpacity(0.2)
                                : AppColors.textBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              icon,
                              color: widget.isPremium
                                  ? const Color(0xFFFFD700)
                                  : AppColors.textBlue,
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
                          fontSize: 22,
                          color: isBack
                              ? AppColors.textWhite
                              : (widget.isPremium ? const Color(0xFF1a1a2e) : AppColors.textSecondary),
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
                                : (widget.isPremium
                                    ? const Color(0xFF1a1a2e).withOpacity(0.6)
                                    : AppColors.textSecondary.withOpacity(0.7)),
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
      [const Color(0xFF667eea), const Color(0xFF764ba2)],
      [const Color(0xFFf093fb), const Color(0xFFf5576c)],
      [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
      [const Color(0xFF43e97b), const Color(0xFF38f9d7)],
      [const Color(0xFFfa709a), const Color(0xFFfee140)],
    ];
    return colorSets[index % colorSets.length];
  }

  Widget _buildPremiumFAB() {
    return FloatingActionButton.extended(
      onPressed: () {
      },
      backgroundColor: const Color(0xFFFFD700),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        "Thêm từ mới",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}