import 'package:json_annotation/json_annotation.dart';
part 'leaderboard_entry_model.g.dart';

@JsonSerializable()
class LeaderBoardEntry{
  final int rank;
  final String username;
  @JsonKey(name:'total_balance')
  final int altruePoints;
  @JsonKey(name:'profile_image')
  final String? profileImage;
  @JsonKey(name:'altrue_level_number')
  final int levelNumber;

  LeaderBoardEntry({required this.levelNumber, required this.rank, this.profileImage, required this.username, required this.altruePoints});

  factory LeaderBoardEntry.fromJson(Map<String, dynamic>data) => _$LeaderBoardEntryFromJson(data);

  Map<String, dynamic> toJson() => _$LeaderBoardEntryToJson(this);

}