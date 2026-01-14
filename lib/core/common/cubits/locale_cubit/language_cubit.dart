import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../local_data/secure_local_data_helper.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SecureLocalDataHelper _prefs;

  LanguageCubit(this._prefs) : super(const LanguageState(Locale('en'))) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final savedLocale = await _prefs.getLocale();
    emit(LanguageState(Locale(savedLocale)));
  }

  Future<void> changeLanguage(Locale locale) async {
    await _prefs.setLocale(locale.languageCode);
    emit(LanguageState(locale));
  }
}
