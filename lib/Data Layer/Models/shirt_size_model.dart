import 'package:json_annotation/json_annotation.dart';
part 'shirt_size_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShirtSize {
  @JsonKey(name: 'size')
  final int? id;
  @JsonKey(name: 'sizevalue')
  final String size;

  ShirtSize({required this.id, required this.size});

  factory ShirtSize.fromJson(Map<String, dynamic> data) =>
      _$ShirtSizeFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtSizeToJson(this);
}
