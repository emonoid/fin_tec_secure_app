import 'package:equatable/equatable.dart';
import 'package:fin_smart/core/utils/enums.dart';

class AppUserState extends Equatable {
  final AppUserStatus status;
  final String? accessToken;

  const AppUserState({required this.status, this.accessToken});

  factory AppUserState.initial() {
    return const AppUserState(status: AppUserStatus.unknown);
  }

  AppUserState copyWith({AppUserStatus? status, String? accessToken}) {
    return AppUserState(
      status: status ?? this.status,
      accessToken: accessToken,
    );
  }

  @override
  List<Object?> get props => [status, accessToken];
}
