import 'package:fin_smart/core/common/cubits/app_user/user_session_state.dart';
import 'package:fin_smart/core/local_data/secure_local_data_helper.dart';
import 'package:fin_smart/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSessionCubit extends Cubit<UserSessionState> {
  final SecureLocalDataHelper localData;

  UserSessionCubit(this.localData)
    : super(UserSessionState(status: UserSessionStatus.unknown));

  void setAppUserStatus(UserSessionStatus status, {String? accessToken}) {
    emit(state.copyWith(status: status, accessToken: accessToken));
  }
}
