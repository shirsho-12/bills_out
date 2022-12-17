import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class CloudEvent {
  const CloudEvent();
}

// class CloudEventInitialize extends CloudEvent {
//   const CloudEventInitialize();
// }

class CloudEventGetBillUser extends CloudEvent {
  final String email;
  const CloudEventGetBillUser({required this.email});
}

class CloudEventUpdateBillUser extends CloudEvent {
  final String? userName;
  final String email;
  final String? userAvatarLink;
  final String? name;
  const CloudEventUpdateBillUser({
    required this.email,
    this.userName,
    this.userAvatarLink,
    this.name,
  });
}
