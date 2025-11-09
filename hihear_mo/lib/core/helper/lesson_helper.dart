// helper.dart (tách ra file nếu muốn)
import 'package:flutter/material.dart';

class LessonHelper {
  static List<Color> getLessonColors(String lessonId) {
    const colorSets = [
      [Color(0xFFB22222), Color(0xFF8B0000)], // đỏ tối
      [Color(0xFFB8860B), Color(0xFF8B7500)], // vàng gold tối
      [Color(0xFF2E4D1B), Color(0xFF3A6622)], // xanh tre tối
      [Color(0xFFCC4B2B), Color(0xFFB04A35)], // cam tối
      [Color(0xFF5056C0), Color(0xFF4B3B8C)], // tím tối
      [Color(0xFF2DBE5D), Color(0xFF26A48F)], // xanh mint tối
      [Color(0xFF6A1B9A), Color(0xFF4A148C)], // tím đậm
      [Color(0xFF1E88E5), Color(0xFF1565C0)], // xanh dương tối
      [Color(0xFF00897B), Color(0xFF00695C)], // xanh teal tối
      [Color(0xFFEF6C00), Color(0xFFE65100)], // cam đất tối
    ];
    return colorSets[lessonId.hashCode % colorSets.length];
  }

  static final Map<String, String> categoryIcons = {
    'Chào hỏi': '👋',
    'Đếm số': '🧮',
    'Từ vựng': '📝',
    'Ngữ pháp': '📖',
    'Nghe': '🎧',
    'Nói': '🗣️',
    'Văn hóa': '🪷',
  };

  static String getIconForCategory(String category) {
    return categoryIcons[category] ?? '📚';
  }
}
