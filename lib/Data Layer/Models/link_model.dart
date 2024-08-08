import 'package:json_annotation/json_annotation.dart';
import 'package:lovelovelove/Data%20Layer/Models/company_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';

import 'atrocity_model.dart';
part 'link_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Link {
  final String title;
  final String link;
  Atrocity? atrocity;
  ForProfitCompany? company;
  NonProfit? nonprofit;
  final String author;
  final String publication;

  Link(
    this.atrocity,
    this.company,
    this.nonprofit, {
    required this.link,
    required this.author,
    required this.publication,
    required this.title,
  });

  factory Link.fromJson(Map<String, dynamic> data) => _$LinkFromJson(data);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
