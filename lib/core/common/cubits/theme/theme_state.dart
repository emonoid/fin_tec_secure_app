import 'package:equatable/equatable.dart';
import '../../../utils/enums.dart';

class ThemeState extends Equatable {
  final ThemeModes theme;

  const ThemeState(this.theme);

  @override
  List<Object> get props => [theme];
}
