import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../local_data/secure_local_data_helper.dart';
import '../../../utils/enums.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SecureLocalDataHelper _prefs;

  ThemeCubit(this._prefs) : super(const ThemeState(ThemeModes.light)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final storedTheme = await _prefs.getTheme();
    emit(
      ThemeState(storedTheme == 'dark' ? ThemeModes.dark : ThemeModes.light),
    );
  }

  Future<void> changeTheme(ThemeModes theme) async {
    await _prefs.setTheme(theme.name);
    emit(ThemeState(theme));
  }
}
