import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hihear_mo/core/enums/language_type.dart';
import 'package:hihear_mo/core/constants/app_colors.dart';
import 'package:hihear_mo/core/constants/app_text_styles.dart';
import 'package:hihear_mo/presentation/blocs/language/language_bloc.dart';
import 'package:hihear_mo/l10n/app_localizations.dart';

class LanguageSettingPage extends StatelessWidget {
  const LanguageSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LanguageBloc>().state.locale;

    final languages = {
      LanguageType.vietnamese: loc.languageVietnamese,
      LanguageType.english: loc.languageEnglish,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          loc.languageSelectTitle,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 104, 4),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: LanguageType.values.map((lang) {
          final isSelected = currentLocale.languageCode == lang.code;
          return ListTile(
            leading: Icon(
              lang == LanguageType.english ? Icons.language : Icons.flag,
              color: Colors.white,
            ),
            title: Text(
              languages[lang]!,
              style: AppTextStyles.title.copyWith(color: Colors.white),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                : const SizedBox(),
            onTap: () {
              context.read<LanguageBloc>().add(ChangeLanguageEvent(lang));
            },
          );
        }).toList(),
      ),
    );
  }
}
