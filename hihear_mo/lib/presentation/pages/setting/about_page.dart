import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

import '../../painter/bamboo_painter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 1000),
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
    final l10n = AppLocalizations.of(context)!;

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
                _buildAppBar(context, l10n),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: FadeTransition(
                      opacity: _fadeController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),

                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD4AF37),
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                AppAssets.logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFD4AF37),
                                  Color(0xFFB8941E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('🇻🇳', style: TextStyle(fontSize: 24)),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.aboutAppName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              l10n.aboutVersion,
                              style: const TextStyle(
                                color: Color(0xFF2D5016),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 28),

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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('🪷', style: TextStyle(fontSize: 28)),
                                    SizedBox(width: 8),
                                    Text('📚', style: TextStyle(fontSize: 28)),
                                    SizedBox(width: 8),
                                    Text('🎯', style: TextStyle(fontSize: 28)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.aboutDescription,
                                  style: const TextStyle(
                                    color: Color(0xFF2D5016),
                                    fontSize: 15,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 28),

                          _buildInfoCard(
                            '👨‍💻',
                            l10n.aboutDeveloper,
                            l10n.aboutDeveloperValue,
                            const Color(0xFF4A7C2C),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            '📧',
                            l10n.aboutEmail,
                            l10n.aboutEmailValue,
                            const Color(0xFFDA291C),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            '🌐',
                            l10n.aboutWebsite,
                            l10n.aboutWebsiteValue,
                            const Color(0xFF667eea),
                          ),

                          const SizedBox(height: 32),

                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFD4AF37),
                                            Color(0xFFB8941E),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '✨',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Tính năng nổi bật',
                                      style: TextStyle(
                                        color: Color(0xFF2D5016),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildFeatureItem('📖', 'Học từ vựng tiếng Việt'),
                                _buildFeatureItem('🎤', 'Luyện phát âm chuẩn'),
                                _buildFeatureItem('💾', 'Lưu từ yêu thích'),
                                _buildFeatureItem('📊', 'Theo dõi tiến độ'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFFD4AF37).withOpacity(0.5),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  '🇻🇳',
                                  style: TextStyle(fontSize: 32),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.aboutCopyright,
                                  style: const TextStyle(
                                    color: Color(0xFF2D5016),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
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

  Widget _buildAppBar(BuildContext context, AppLocalizations l10n) {
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
              onPressed: () {
                context.go('/home');
              },
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
                const Text('ℹ️', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  l10n.aboutTitle,
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

  Widget _buildInfoCard(String emoji, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.2),
                  color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF2D5016).withOpacity(0.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF2D5016),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: Color(0xFF4A7C2C),
            size: 20,
          ),
        ],
      ),
    );
  }
}
