import 'package:json_annotation/json_annotation.dart';

part 'join_request.g.dart';

@JsonSerializable()
class JoinRequest{
  final String memberId;
  final String password;

  JoinRequest({
    required this.memberId,
    required this.password
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json)
  => _$JoinRequestFromJson(json);

  Map<String, dynamic> toJson()
  => _$JoinRequestToJson(this);
}