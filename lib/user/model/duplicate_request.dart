import 'package:json_annotation/json_annotation.dart';

part 'duplicate_request.g.dart';

@JsonSerializable()
class DuplicateRequest {

  final String email;


  DuplicateRequest({
    required this.email
  });

  factory DuplicateRequest.fromJson(Map<String, dynamic> json)
    => _$DuplicateRequestFromJson(json);

  Map<String, dynamic> toJson()
    => _$DuplicateRequestToJson(this);
}