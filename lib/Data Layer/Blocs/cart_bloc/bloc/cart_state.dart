part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, changing }

class CartState extends Equatable {
  final List<OrderItem> cart;
  final CartStatus status;
  Cart? apiCart;
  final double? total;

  CartState(
      {this.apiCart,
      this.cart = const [],
      this.status = CartStatus.initial,
      this.total = 0});

  CartState copyWith(
      {List<OrderItem>? cart,
      CartStatus? status,
      Cart? apiCart,
      double? total}) {
    return CartState(
        cart: cart ?? this.cart,
        status: status ?? this.status,
        apiCart: apiCart ?? this.apiCart,
        total: total ?? this.total);
  }

  double getCartPriceTotal() {
    double total = 0;
    for (OrderItem item in cart) {
      double itemOrderTotal = item.shirt.price! * item.quantity;
      total += itemOrderTotal;
    }
    return double.parse((total).toStringAsFixed(2));
  }

  String getCartPointTotal() {
    double total = 0;
    for (OrderItem item in cart) {
      int pointTotal = item.shirt.pointsNeededToPurchase! * item.quantity;
      total += pointTotal;
    }
    return total.toString();
  }

  @override
  List<Object> get props => [
        cart,
        status,
      ];
}

class CartInitial extends CartState {}
