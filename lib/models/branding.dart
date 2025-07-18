import 'package:json_annotation/json_annotation.dart';

part 'branding.g.dart';

@JsonSerializable()
class Branding {
  final String logoUrl;
  final String themeColor;

  Branding({required this.logoUrl, required this.themeColor});

  factory Branding.fromJson(Map<String, dynamic> json) =>
      _$BrandingFromJson(json);
  Map<String, dynamic> toJson() => _$BrandingToJson(this);
}
