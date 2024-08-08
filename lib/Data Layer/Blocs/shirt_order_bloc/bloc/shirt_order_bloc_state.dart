part of 'shirt_order_bloc_bloc.dart';

enum ShirtColorStatus { Changing, Initial }

class ShirtOrderBlocState extends Equatable {
  final ShirtColor? color;
  final int quantity;
  final ShirtSize? size;
  final String? shirtImageUrl;
  final List<ShirtColor> colors;
  final ShirtColorStatus status;

  const ShirtOrderBlocState({
    this.colors = const [],
    this.status = ShirtColorStatus.Initial,
    this.quantity = 1,
    this.color,
    this.size,
    this.shirtImageUrl,
  });

  ShirtOrderBlocState copyWith(
      {ShirtColor? color,
      ShirtColorStatus? status,
      List<ShirtColor>? colors,
      Shirt? shirt,
      int? quantity,
      ShirtSize? size,
      String? shirtImageUrl}) {
    return ShirtOrderBlocState(
        status: status ?? this.status,
        colors: colors ?? this.colors,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        shirtImageUrl: shirtImageUrl ?? this.shirtImageUrl,
        size: size ?? this.size);
  }

  @override
  List<Object> get props => [color!, quantity, size!, shirtImageUrl!, status];
}

class ShirtPicChanged extends ShirtOrderBlocState {
  final ShirtVariation variation;

  const ShirtPicChanged({required this.variation});

  @override
  List<Object> get props => [variation];
}

class OrderChanging extends ShirtOrderBlocState {
  @override
  List<Object> get props => [];
}

class OrderInProgress extends ShirtOrderBlocState {
  final Shirt shirt;
  const OrderInProgress({required this.shirt});
  @override
  List<Object> get props => [];
}

class OrderSubmitted extends ShirtOrderBlocState {
  final String message;

  const OrderSubmitted({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderError extends ShirtOrderBlocState {
  @override
  List<Object> get props => throw UnimplementedError();
}
