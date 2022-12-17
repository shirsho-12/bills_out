import 'package:bloc/bloc.dart';
import 'package:bills_out/services/cloud/bloc/cloud_event.dart';
import 'package:bills_out/services/cloud/bloc/cloud_state.dart';
import 'package:bills_out/services/cloud/firebase_cloud_storage.dart';

class CloudBloc extends Bloc<CloudEvent, CloudState> {
  final _storage = FirebaseCloudStorage();

  CloudBloc() : super(const CloudStateInitialized()) {
    on<CloudEventGetBillUser>(_onGetAppUser);
    // on<CloudEventCreateAppUser>(_onCreateAppUser);
    on<CloudEventUpdateBillUser>(_onUpdateAppUser);
  }

  void _onGetAppUser(CloudEventGetBillUser event, emit) async {
    try {
      emit(CloudStateGetBillUser(
          user: await _storage.getAppUserFromEmail(
        event.email,
      )));
    } on Exception catch (e) {
      emit(CloudStateGetBillUser(user: null, exception: e));
    }
  }
  // New users are only created during registration
  // void _onCreateAppUser(CloudEventCreateAppUser event, emit) async {
  //   try {
  //     await _storage.createNewAppUser(
  //         userAuthId: event.userAuthId,
  //         fullName: event.fullName,
  //         email: event.email,
  //         department: event.department);
  //     emit(const CloudStateCreateAppUser());
  //   } on Exception catch (e) {
  //     emit(CloudStateCreateAppUser(exception: e));
  //   }
  // }

  void _onUpdateAppUser(CloudEventUpdateBillUser event, emit) async {
    try {
      await _storage.updateBillUser(
        email: event.email,
        userName: event.userName,
        name: event.name,
        userAvatarLink: event.userAvatarLink,
      );
      emit(const CloudStateUpdateAppUser());
    } on Exception catch (e) {
      emit(CloudStateUpdateAppUser(exception: e));
    }
  }
}
