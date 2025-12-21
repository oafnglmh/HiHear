import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hihear_mo/core/constants/app_constants.dart';

class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const FloatingNavBar({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.large).copyWith(bottom: AppPadding.large),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.navBar),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.navBar),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.medium, vertical: AppPadding.medium),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(AppRadius.navBar),
              border: Border.all(
                color: const Color(0xFFD4AF37),
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildItem(Icons.home_rounded, 0),
                _buildItem(Icons.mic_rounded, 1),
                _buildItem(Icons.smart_toy, 2),
                _buildItem(Icons.bookmark_rounded, 3),
                _buildItem(Icons.person_rounded, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.large, vertical: AppPadding.medium),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color(0xFFD4AF37),
                    Color(0xFFB8941E),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(AppRadius.large),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF2D5016),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}