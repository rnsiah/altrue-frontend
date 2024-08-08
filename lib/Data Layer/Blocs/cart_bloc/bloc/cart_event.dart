part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartSubmitted extends CartEvent {
  const CartSubmitted();
}

class CartItemAdded extends CartEvent {
  final DatabaseOrderItem orderItem;
  const CartItemAdded({required this.orderItem});
}

class CartEmptied extends CartEvent {}

class CartItemEdited extends CartEvent {
  final OrderItem orderItem;
  final ShirtSize shirtSize;
  final ShirtColor shirtColor;
  final int qauntity;
  const CartItemEdited(
      {required this.orderItem,
      required this.qauntity,
      required this.shirtColor,
      required this.shirtSize});
}

class CartItemQuantityEdited extends CartEvent {
  final int quantity;
  const CartItemQuantityEdited({required this.quantity});
}

class CartItemSizeEdited extends CartEvent {
  final ShirtSize size;
  const CartItemSizeEdited({required this.size});
}

class CartItemColorEdited extends CartEvent {
  final ShirtColor color;
  const CartItemColorEdited({required this.color});
}

class CartBeingLoaded extends CartEvent {}

class CartItemDeleted extends CartEvent {
  final OrderItem item;
  const CartItemDeleted({required this.item});
}

class PaymentAccepted extends CartEvent {}
