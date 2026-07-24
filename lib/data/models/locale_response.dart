import 'package:json_annotation/json_annotation.dart';

part 'locale_response.g.dart';

@JsonSerializable(createToJson: false)
class LocaleResponse {
  const LocaleResponse({required this.data});

  @JsonKey(defaultValue: {})
  final Map<String, dynamic> data;

  factory LocaleResponse.fromJson(Map<String, dynamic> json) =>
      _$LocaleResponseFromJson(json);
}
