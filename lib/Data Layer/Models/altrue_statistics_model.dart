import 'package:json_annotation/json_annotation.dart';
part 'altrue_statistics_model.g.dart';

@JsonSerializable()
class AltrueStatistics {
  @JsonKey(name:'total_users')
  int totalUsers;
  @JsonKey(name:'total_amount_raised')
  String totalAmountRaised;
  @JsonKey(name:'total_donated')
  String totalDonated;
  @JsonKey(name:'total_points_accumulated')
  String totalPointsAccumulated;
  @JsonKey(name:'total_nonprofits')
  int totalNonprofits;
  @JsonKey(name:'total_companies')
  int totalCompanies;
  @JsonKey(name:'total_atrocities')
  int totalAtrocities;
  @JsonKey(name:'total_donors')
  int totalDonors;

  AltrueStatistics({
    required this.totalUsers,
    required this.totalAmountRaised,
    required this.totalDonated,
    required this.totalPointsAccumulated,
    required this.totalNonprofits,
    required this.totalCompanies,
    required this.totalAtrocities,
    required this.totalDonors,
  });

  factory AltrueStatistics.fromJson(Map<String, dynamic> data) =>
      _$AltrueStatisticsFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueStatisticsToJson(this); 
}