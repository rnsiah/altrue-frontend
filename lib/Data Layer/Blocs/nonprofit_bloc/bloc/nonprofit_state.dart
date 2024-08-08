part of 'nonprofit_bloc.dart';

enum NonProfitStatus { initial, success, failure }

class NonprofitState extends Equatable {
  final List<NonProfit> nonprofitList;
  final NonProfitStatus status;
  final List<NonProfit> categoryNonProfitList;
  final bool categoryChange;
  final List<NonProfit> featuredNonProfits;

  const NonprofitState(
      {this.nonprofitList = const <NonProfit>[],
      this.status = NonProfitStatus.initial,
      this.categoryChange = false,
      this.categoryNonProfitList = const <NonProfit>[],
      this.featuredNonProfits = const <NonProfit>[]});

  NonprofitState copyWith(
      {final List<NonProfit>? nonprofitList,
      final NonProfitStatus? status,
      final List<NonProfit>? categoryNonProfitList,
      final List<NonProfit>? featuredNonProfits,
      final bool? categoryChange}) {
    return NonprofitState(
        featuredNonProfits: featuredNonProfits ?? this.featuredNonProfits,
        categoryNonProfitList:
            categoryNonProfitList ?? this.categoryNonProfitList,
        categoryChange: categoryChange ?? this.categoryChange,
        nonprofitList: nonprofitList ?? this.nonprofitList,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        nonprofitList,
        status,
        categoryChange,
        categoryNonProfitList,
        featuredNonProfits
      ];
}

class NonProfitFailure extends NonprofitState {}
