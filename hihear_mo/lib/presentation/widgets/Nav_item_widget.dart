import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final bool isPremium;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.isPremium,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.all(isSelected ? 14 : 12),
        decoration: BoxDecoration(
          gradient: isSelected && isPremium
              ? const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                )
              : null,
          color: isSelected && !isPremium
              ? const Color(0xFFFF8C50)
              : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (isPremium
                            ? const Color(0xFFFFD700)
                            : const Color(0xFFFF8C50))
                        .withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected
              ? Colors.white
              : (isPremium
                  ? Colors.white.withOpacity(0.6)
                  : const Color(0xFF666666)),
          size: 24,
        ),
      ),
    );
  }
}
