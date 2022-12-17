part of 'user.dart';

BillUser _$UserFromJson(Map<String, dynamic> json) => BillUser(
      userName: json['userName'] as String,
      userAvatarLink: json['userAvatarLink'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(BillUser instance) => <String, dynamic>{
      'userName': instance.userName,
      'userAvatarLink': instance.userAvatarLink,
      'name': instance.name,
      'email': instance.email,
    };
