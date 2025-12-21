import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'dart:math' as math;

import 'package:hihear_mo/presentation/blocs/save_vocab/save_vocab_bloc.dart';
import 'package:hihear_mo/share/UserShare.dart';
import 'package:hihear_mo/domain/entities/VocabUserEntity/vocab_user_entity.dart';

import '../../painter/lotus_pattern_painter.dart';
import '../../painter/ripple_painter.dart';

class SavedVocabPage extends StatefulWidget {
  const SavedVocabPage({super.key});

  @override
  State<SavedVocabPage> createState() => _SavedVocabPageState();
}

class _SavedVocabPageState extends State<SavedVocabPage>
    with TickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  
  late AnimationController _lotusController;
  late AnimationController _rippleController;
  late AnimationController _floatingController;
  late AnimationController _fadeController;

  List<VocabUserEntity> _allVocab = [];
  List<VocabUserEntity> _filteredVocab = [];

  @override
  void initState() {
    super.initState();
    UserShare().debugPrint();
    context.read<SaveVocabBloc>().add(SaveVocabEvent.loadVocabUserById(
      id: UserShare().id ?? '',
    ));
    
    _searchController.addListener(_onSearchChanged);
    
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

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _tts.stop();
    _searchController.dispose();
    _lotusController.dispose();
    _rippleController.dispose();
    _floatingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredVocab = _allVocab.where((vocab) {
        final word = vocab.word.toLowerCase();
        final meaning = vocab.meaning.toLowerCase();
        return word.contains(query) || meaning.contains(query);
      }).toList();
    });
  }

  Future<void> _speak(String word) async {
    await _tts.setLanguage("vi-VN");

    await _tts.setPitch(1.0);
    await _tts.speak(word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: FadeTransition(
              opacity: _fadeController,
              child: BlocConsumer<SaveVocabBloc, SaveVocabState>(
                listener: (context, state) {
                  state.maybeWhen(
                    vocabUserData: (vocabUsers) {
                      setState(() {
                        _allVocab = vocabUsers;
                        _filteredVocab = vocabUsers;
                      });
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                    orElse: () => SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHeader(),
                          _buildSearchBar(),
                          _buildStatsBar(),
                          _buildVocabGrid(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 4),
          child: Container(
            margin: const EdgeInsets.all(20),
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
                color: const Color(0xFFD4AF37),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFFB8941E)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.bookmark_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.savedVocabTitle,
                        style: TextStyle(
                          color: Color(0xFF2D5016),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.savedVocabCount(_allVocab.length),
                        style: TextStyle(
                          color: const Color(0xFF2D5016).withOpacity(0.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4AF37).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Color(0xFF2D5016),
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: l10n.savedVocabSearchHint,
            hintStyle: TextStyle(
              color: const Color(0xFF2D5016).withOpacity(0.5),
              fontSize: 16,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFD4AF37),
              size: 26,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: const Color(0xFF2D5016).withOpacity(0.5),
                      size: 24,
                    ),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white.withOpacity(0.95),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: const Color(0xFFD4AF37).withOpacity(0.4),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFFD4AF37),
                width: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsBar() {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatingController.value * math.pi * 2 + 1) * 3),
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  _filteredVocab.length.toString(),
                  l10n.savedVocabDisplayedLabel,
                  const Color(0xFFD4AF37),
                ),
                Container(
                  width: 2,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.1),
                        const Color(0xFFD4AF37).withOpacity(0.3),
                        const Color(0xFFD4AF37).withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                _buildStatItem(
                  _allVocab.length.toString(),
                  l10n.savedVocabTotalLabel,
                  const Color(0xFF1B7F4E),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF2D5016).withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabGrid() {
    final l10n = AppLocalizations.of(context)!;
    if (_filteredVocab.isEmpty) {
      return AnimatedBuilder(
        animation: _floatingController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, math.sin(_floatingController.value * math.pi * 2) * 5),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(40),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.95),
                      Colors.white.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFD4AF37),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFD4AF37),
                            Color(0xFFB8941E),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search_off_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _allVocab.isEmpty 
                          ? l10n.savedVocabEmptyTitle
                          : l10n.savedVocabNoResultTitle,
                      style: const TextStyle(
                        color: Color(0xFF2D5016),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _allVocab.isEmpty 
                          ? l10n.savedVocabEmptySubtitle
                          : l10n.savedVocabNoResultSubtitle,
                      style: TextStyle(
                        color: const Color(0xFF2D5016).withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
          childAspectRatio: 0.8,
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

  Widget _buildFlipCard(VocabUserEntity vocab, int index) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      speed: 500,
      front: _buildCardFace(
        title: vocab.word,
        icon: Icons.volume_up_rounded,
        onIconPressed: () => _speak(vocab.word),
        index: index,
      ),
      back: _buildCardFace(
        title: vocab.meaning,
        isBack: true,
        index: index,
      ),
    );
  }

  Widget _buildCardFace({
    required String title,
    String? subtitle,
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
            : LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors[0].withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (!isBack) ...[
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors[0].withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      colors[1].withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors[0].withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        icon,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: onIconPressed,
                    ),
                  ),
                if (icon != null) const SizedBox(height: 16),
                
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: isBack ? Colors.white : const Color(0xFF2D5016),
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                
                if (subtitle != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isBack
                          ? Colors.white.withOpacity(0.2)
                          : colors[0].withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isBack
                            ? Colors.white.withOpacity(0.9)
                            : colors[0],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
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
      [const Color(0xFF1B7F4E), const Color(0xFF0D6B3D)],
      [const Color(0xFFFF6B35), const Color(0xFFFF8C50)],
      [const Color(0xFF667eea), const Color(0xFF764ba2)],
    ];
    return colorSets[index % colorSets.length];
  }
}