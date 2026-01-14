import 'package:equatable/equatable.dart';
import 'package:fin_smart/core/utils/enums.dart';

class UserSessionState extends Equatable {
  final UserSessionStatus status;
  final String? accessToken;

  const UserSessionState({required this.status, this.accessToken});

  factory UserSessionState.initial() {
    return const UserSessionState(status: UserSessionStatus.unknown);
  }

  UserSessionState copyWith({UserSessionStatus? status, String? accessToken}) {
    return UserSessionState(
      status: status ?? this.status,
      accessToken: accessToken,
    );
  }

  @override
  List<Object?> get props => [status, accessToken];
}
