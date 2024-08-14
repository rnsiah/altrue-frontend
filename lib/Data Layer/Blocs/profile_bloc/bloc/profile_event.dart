part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class CreateCompanyMatch extends ProfileEvent {
  final SendCompanyNonProfitRelationShip relationship;
  const CreateCompanyMatch({required this.relationship});
}

class FetchProfile extends ProfileEvent {
  const FetchProfile();
}

class CreatePaymentMethod extends ProfileEvent {
  final String cardNumber;
  final int expMonth;
  final String cvv;
  final int expYear;
  final String cardholderName;

  const CreatePaymentMethod(
      {required this.cardNumber,
      required this.expMonth,
      required this.expYear,
      required this.cardholderName,
      required this.cvv});
}

class FetchPaymentMethod extends ProfileEvent{
  

  
}



class RateSomething extends ProfileEvent {
  final Rating rating;

  const RateSomething({required this.rating});
}

class MakeDonationWithUserFunds extends ProfileEvent {
  final DonationData donationData;
  const MakeDonationWithUserFunds({required this.donationData});
}

class MakeDonationWithAltrueFunds extends ProfileEvent {
  final NonProfit? nonprofit;
  final Atrocity? atrocity;
  final NonProfitProject? project;
  final double amount;

  const MakeDonationWithAltrueFunds({
    required this.nonprofit,
    required this.atrocity,
    required this.project,
    required this.amount,
  });
}

class CheckDonationStatus extends ProfileEvent {}

class PayWithPoints extends ProfileEvent {
  final List<OrderItem>? shirts;
  const PayWithPoints({required this.shirts});
}

class LoadQR extends ProfileEvent {
  final Profile profile;
  const LoadQR({required this.profile});
}

class FetchProfileAutoLogin extends ProfileEvent {
  const FetchProfileAutoLogin();
}

class AddShirt extends ProfileEvent {
  final Shirt addedShirt;
  const AddShirt({required this.addedShirt});
}

class DeleteShirt extends ProfileEvent {
  final Shirt deletedShirt;
  const DeleteShirt({required this.deletedShirt});
}

class AddAtrocity extends ProfileEvent {
  final Atrocity atrocity;
  const AddAtrocity({required this.atrocity});
}

class AddNonProfit extends ProfileEvent {
  final NonProfit nonProfit;
  const AddNonProfit({required this.nonProfit});
}

class ChangeProfilePicture extends ProfileEvent {
  final XFile profilePicture;
  const ChangeProfilePicture({required this.profilePicture});
}

class AddUserToFollow extends ProfileEvent {
  final int profileToFollow;
  const AddUserToFollow({required this.profileToFollow});
}

class AddOrderItem extends ProfileEvent {
  final OrderItem orderItem;
  const AddOrderItem({required this.orderItem});
}

class SubmitOrderItems extends ProfileEvent {
  final List<OrderItem> orderItems;
  const SubmitOrderItems({required this.orderItems});
}

class AddFollower extends ProfileEvent {
  final ManageFollower interaction;

  const AddFollower({required this.interaction});
}

class RemoveFollower extends ProfileEvent {
  final ManageFollower interaction;
  const RemoveFollower({required this.interaction});
}

class CreatePaymentIntentForPurchase extends ProfileEvent {
  final int amount;
  final List<OrderItem>? shirts;

  const CreatePaymentIntentForPurchase({
    required this.amount,
    required this.shirts,
  });
}

class InitPaymentSheetForPurchase extends ProfileEvent {
  const InitPaymentSheetForPurchase();
}

class GetOrderStatus extends ProfileEvent {
  final String stripeId;

  const GetOrderStatus({required this.stripeId});
}

class HybridPaymentPoints extends ProfileEvent {
  final int? pointAmount;
  final List<OrderItem>? shirts;

  const HybridPaymentPoints({required this.pointAmount, required this.shirts});
}

class ConfirmOrder extends ProfileEvent {}

class HybridPaymentFunds extends ProfileEvent {}

class HybridPayment extends ProfileEvent {
  final int? pointAmount;
  final List<OrderItem>? shirts;

  const HybridPayment({required this.pointAmount, required this.shirts});
}


class SubmitQuizScore extends ProfileEvent{
  final QuizResult quizResult;
  const SubmitQuizScore({required this.quizResult});
}

class LogOut extends ProfileEvent {}
