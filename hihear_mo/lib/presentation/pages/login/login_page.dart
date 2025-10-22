import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_assets.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoAnimation = Tween<Alignment>(
      begin: Alignment(-1.5, -0.5),
      end: Alignment(0, -0.5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.background, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.2)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: _logoAnimation.value,
                    child: Image.asset(AppAssets.logo, height: 180, width: 180),
                  );
                },
              ),
              const SizedBox(height: 30),
              Text(
                l10n.translWelcome,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black26,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 280,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/goalSelector');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 6,
                  ),
                  icon: Image.asset(
                    AppAssets.googleIcon,
                    height: 30,
                    width: 30,
                  ),
                  label: Text(
                    l10n.translLoginGg,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 280,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1877F2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 6,
                  ),
                  icon: Icon(Icons.facebook, size: 30),
                  label: Text(
                    l10n.translLoginFb,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
