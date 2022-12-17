import 'package:bills_out/models/user.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

@immutable
abstract class CloudState extends Equatable {
  const CloudState();
}

class CloudStateInitialized extends CloudState {
  const CloudStateInitialized();

  @override
  List<Object?> get props => [];
}

class CloudStateGetBillUser extends CloudState {
  final BillUser? user;
  final Exception? exception;
  const CloudStateGetBillUser({this.user, this.exception});

  @override
  List<Object?> get props => [exception, user];
}

class CloudStateUpdateAppUser extends CloudState {
  final Exception? exception;
  const CloudStateUpdateAppUser({this.exception});

  @override
  List<Object?> get props => [exception];
}

// class CloudStateCreateAppUser extends CloudState {
//   final AppUserData? user;
//   final Exception? exception;
//   const CloudStateCreateAppUser({this.user, this.exception});

//   @override
//   List<Object?> get props => [exception, user];
// }

