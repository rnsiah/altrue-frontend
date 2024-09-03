// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoardEntry _$LeaderBoardEntryFromJson(Map<String, dynamic> json) =>
    LeaderBoardEntry(
      levelNumber: (json['altrue_level_number'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      profileImage: json['profile_image'] as String?,
      username: json['username'] as String,
      altruePoints: (json['total_balance'] as num).toInt(),
    );

Map<String, dynamic> _$LeaderBoardEntryToJson(LeaderBoardEntry instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'username': instance.username,
      'total_balance': instance.altruePoints,
      'profile_image': instance.profileImage,
      'altrue_level_number': instance.levelNumber,
    };
