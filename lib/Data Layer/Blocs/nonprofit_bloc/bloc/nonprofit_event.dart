part of 'nonprofit_bloc.dart';

abstract class NonprofitEvent extends Equatable {
  const NonprofitEvent();

  @override
  List<Object> get props => [];
}

class FetchNonProfitList extends NonprofitEvent {}

class FetchNonProfitItem extends NonprofitEvent {
  final NonProfit nonProfit;

  const FetchNonProfitItem({required this.nonProfit});

  @override
  List<Object> get props => [nonProfit];
}

class FetchNonProfitsByCategory extends NonprofitEvent {
  final Category category;
  const FetchNonProfitsByCategory({required this.category});
}
