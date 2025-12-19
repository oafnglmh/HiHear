import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/enums/language_type.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';
import 'package:hihear_mo/presentation/painter/bamboo_painter.dart';

class LanguageSettingPage extends StatefulWidget {
  const LanguageSettingPage({super.key});

  @override
  State<LanguageSettingPage> createState() => _LanguageSettingPageState();
}

class _LanguageSettingPageState extends State<LanguageSettingPage> 
    with TickerProviderStateMixin {
  late AnimationController _bambooController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    
    _bambooController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _bambooController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LanguageBloc>().state.locale;

    final languages = {
      LanguageType.vietnamese: {
        'name': loc.languageVietnamese,
        'emoji': '🇻🇳',
        'nativeName': 'Tiếng Việt',
      },
      LanguageType.english: {
        'name': loc.languageEnglish,
        'emoji': '🇬🇧',
        'nativeName': 'English',
      },
    };

    return Scaffold(
      body: Stack(
        children: [
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
            child: Column(
              children: [
                _buildAppBar(context, loc),

                Expanded(
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          
                          Container(
                            padding: const EdgeInsets.all(24),
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
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text('🌍', style: TextStyle(fontSize: 48)),
                                const SizedBox(height: 12),
                                Text(
                                  'Chọn ngôn ngữ',
                                  style: TextStyle(
                                    color: const Color(0xFF2D5016),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Select your language',
                                  style: TextStyle(
                                    color: const Color(0xFF2D5016).withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          ...LanguageType.values.map((lang) {
                            final isSelected = 
                                currentLocale.languageCode == lang.code;
                            final langData = languages[lang]!;

                            return TweenAnimationBuilder<double>(
                              duration: Duration(
                                milliseconds: 400 + (lang.index * 100),
                              ),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: 0.8 + (value * 0.2),
                                  child: Opacity(
                                    opacity: value,
                                    child: _buildLanguageCard(
                                      emoji: langData['emoji']!,
                                      name: langData['name']!,
                                      nativeName: langData['nativeName']!,
                                      isSelected: isSelected,
                                      onTap: () {
                                        context.read<LanguageBloc>().add(
                                          ChangeLanguageEvent(lang),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          
                          const Spacer(),
                          
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text('💡', style: TextStyle(fontSize: 24)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Thay đổi ngôn ngữ sẽ được áp dụng ngay lập tức',
                                    style: TextStyle(
                                      color: const Color(0xFF2D5016).withOpacity(0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => context.go('/home'),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD4AF37).withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                const Text('🌐', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  loc.languageSelectTitle,
                  style: const TextStyle(
                    color: Color(0xFF2D5016),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildLanguageCard({
    required String emoji,
    required String name,
    required String nativeName,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color(0xFFD4AF37),
                    Color(0xFFB8941E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
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
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            
            const SizedBox(width: 20),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nativeName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF2D5016),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.white.withOpacity(0.9)
                          : const Color(0xFF2D5016).withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: child,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_circle_rounded,
                        key: ValueKey(true),
                        color: Colors.white,
                        size: 32,
                      )
                    : Icon(
                        Icons.circle_outlined,
                        key: const ValueKey(false),
                        color: const Color(0xFF2D5016).withOpacity(0.3),
                        size: 32,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}