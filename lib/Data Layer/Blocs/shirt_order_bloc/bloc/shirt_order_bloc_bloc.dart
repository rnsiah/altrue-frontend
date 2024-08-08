import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_color_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_size_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_variation_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_order_repositor.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/shirt_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

part 'shirt_order_bloc_event.dart';
part 'shirt_order_bloc_state.dart';

class ShirtOrderBlocBloc
    extends Bloc<ShirtOrderBlocEvent, ShirtOrderBlocState> {
  UserRepository userRepository = UserRepository();
  ShirtRepository shirtRepository = ShirtRepository();
  ShirtOrderRepository shirtOrderRepository = ShirtOrderRepository();

  ShirtOrderBlocBloc()
      : super(ShirtOrderBlocState(
            size: ShirtSize(id: 0, size: ''),
            color: ShirtColor(color: '', hex: '', id: 0),
            shirtImageUrl: '')) {
    on<ShirtQuantityDecrement>(_shirtQuantityDecrement);
    on<ShirtQuantityIncrement>(_shirtQauntityIncrement);
    on<ShirtOrderSubmitted>(_orderSubmitted);
    on<ShirtColorChange>(_shirtColorChange);
    on<ShirtSizeChange>(_shirtSizeChange);
    on<ShirtPictureChange>(_shirtPictureChange);
    on<ShirtOrderStarted>(_shirtOrderStarted);
  }

  void _shirtOrderStarted(
      ShirtOrderStarted event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    emit(OrderInProgress(shirt: event.shirt));
    print('Shirt Looking At:${event.shirt}');
    try {
      List<ShirtColor> colors = event.shirt.availableColors!;
      ShirtColor colorOfFirstShirt = event.shirt.variations![0].color;
      ShirtSize size = event.shirt.shirtSizes![0];

      ShirtOrderBlocState shirtOrderBlocState = ShirtOrderBlocState(
          colors: colors,
          quantity: 1,
          color: colorOfFirstShirt,
          size: size,
          shirtImageUrl: event.shirt.shirtImage);

      emit(shirtOrderBlocState);
    } catch (e) {
      e.toString();
    }
  }

  void _shirtPictureChange(
      ShirtPictureChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
  }

  void _shirtSizeChange(
      ShirtSizeChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    emit(state.copyWith(size: event.shirtSize));
  }

  void _shirtColorChange(
      ShirtColorChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;

    ShirtVariation shirt = await shirtRepository.shirtVariationImage(
      shirt: event.shirt,
      color: event.shirtColor.color,
    );
    ShirtOrderBlocState newState = state.copyWith(
        status: ShirtColorStatus.Changing,
        shirt: event.shirt,
        shirtImageUrl: shirt.image,
        color: event.shirtColor);
    print(shirt.toString());
    // emit(ShirtPicChanged(variation: shirt));
    emit(newState);
    print('the new shirt color is ${newState.color!.color}');
    // ShirtOrderBlocState newState =
    //     state.copyWith(color: event.shirtColor, shirtImageUrl: shirt.image);

    // emit(newState);

    print(
        'newState:{${newState.color!.color.toString()},${newState.shirtImageUrl.toString()} }');
  }

  void _shirtQuantityDecrement(
      ShirtQuantityDecrement event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void _shirtQauntityIncrement(
      ShirtQuantityIncrement event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _orderSubmitted(
      ShirtOrderSubmitted event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;

    try {
      OrderItem newItem = OrderItem(
          color: state.color!,
          shirt: event.shirt,
          size: state.size!,
          id: event.shirtId,
          quantity: state.quantity);

      print('Item: ${newItem.color.color}, ${newItem.quantity}, ');

      await shirtOrderRepository.sendOrderToDatabase(newItem);
      emit(const OrderSubmitted(message: 'Your order has been submitted'));
      emit(const ShirtOrderBlocState());
    } catch (e) {
      emit(OrderSubmitted(message: e.toString()));
    }
  }
}
