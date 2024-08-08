part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  successfull,
  failure,
  updating,
  rated,
  paymentsheeInitializing,
  paymentSheetError,
  getOrderStatusLoading,
  paymentIntentCreated,
  paymentSheetInitalized,
  paymentAccepted,
  paymentError,
  hybridPayment,
  hybridPaymentPoints,
  hybridPaymentFunds,
  confirmingOrder,
  paymentProcessing,
}

class ProfileState extends Equatable {
  final User? user;
  final Profile? profile;
  final ProfileStatus? status;
  final String? message;
  final Map<String, dynamic>? paymentIntentData;
  final CreditCardDetails? paymentMethodDetails;

  const ProfileState(
      {this.user,
      this.paymentMethodDetails,
      this.profile,
      this.status = ProfileStatus.initial,
      this.paymentIntentData,
      this.message});

  ProfileState copyWith(
      {User? user,
      Profile? profile,
      ProfileStatus? status,
      CreditCardDetails? paymentMethodDetails,
      String? message,
      Map<String, dynamic>? paymentIntentData}) {
    return ProfileState(
        user: user ?? this.user,
        message: message ?? this.message,
        profile: profile ?? this.profile,
        status: status ?? this.status,
        paymentIntentData: paymentIntentData ?? this.paymentIntentData,
        paymentMethodDetails:
            paymentMethodDetails ?? this.paymentMethodDetails);
  }

  @override
  List<Object?> get props =>
      [profile, status, message, paymentIntentData, paymentMethodDetails];

  @override
  String toString() {
    return 'ProfileState{ profile: ${profile?.username}, status: $status, message: $message, paymentIntentData: $paymentIntentData}';
  }
}

class PresentPaymentSheet extends ProfileState {
  final String clientSecret;

  const PresentPaymentSheet({required this.clientSecret});
}

class DonationErrorState extends ProfileState {
  final String errorMessage;

  const DonationErrorState({required this.errorMessage});
}

class PaymentSheetLoading extends ProfileState {}

class PaymentInProgress extends ProfileState {}
