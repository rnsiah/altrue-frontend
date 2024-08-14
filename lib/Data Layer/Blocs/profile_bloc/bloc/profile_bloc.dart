import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/credit_card_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/manage_followers_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/order_item_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/quiz_result_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/shirt_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/company_match_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/ratings_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import '../../../Models/donation_data_model.dart';
import '../../../Models/nonprofit_project_model.dart';
import '../../../Models/rating_model.dart';
import '../../../Models/send_company_nonprofitMatch_model.dart';
import '../../../Models/user_donation_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final RatingsRepository ratingsRepository = RatingsRepository();
  final CompanyMatchRepository companyMatchRepository =
      CompanyMatchRepository();

  ProfileBloc({required this.userRepository})
      : super(const ProfileState(status: ProfileStatus.initial)) {
    on<FetchProfile>(_fetchProfile);
    on<FetchProfileAutoLogin>(_fetchProfileAutoLogin);
    on<AddShirt>(_addShirt);
    on<AddAtrocity>(_addAtrocity);
    on<AddNonProfit>(_addNonProfit);
    // on<AddOrderItem>(_addOrderItem);
    on<AddFollower>(_addFollower);
    on<RemoveFollower>(_removeFollower);
    on<RateSomething>(_rateItem);
    on<SubmitQuizScore>(_submitQuizScore);
    on<CreateCompanyMatch>(_createCompanyMatch);
    on<MakeDonationWithUserFunds>(_makeDonation);
    on<MakeDonationWithAltrueFunds>(_makeDonationWithAltrueWallet);
    on<CreatePaymentIntentForPurchase>(_createPaymentIntentForPurchase);
    on<FetchPaymentMethod>(_fetchPaymentMethod);
    // on<InitPaymentSheetForPurchase>(_initPaymentSheetForPurchase);
    on<ConfirmOrder>(_confirmOrder);
    on<CreatePaymentMethod>(_createPaymentMethod);
    on<PayWithPoints>(_payWithPoints);
    on<HybridPayment>(_hybridPayment);
    on<HybridPaymentPoints>(_hybridPaymentPoints);
    on<HybridPaymentFunds>(_hbridPaymentFunds);
    on<CheckDonationStatus>(_checkDonationStatus);
  }

  void _fetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.updating));
      User? user = await userRepository.userDao.getCurrentUser(0);
      Profile profile = await userRepository.getProfileFromApi(user: user!);
      ProfileState newState = state.copyWith(
          profile: profile, user: user, status: ProfileStatus.successfull);
      emit(newState);
      print('profile has been updated');
    } catch (e) {
      print(e.toString());
    }

    // emit(state.copyWith(profile: state.profile, status: ProfileStatus.failure));
  }

  void _rateItem(RateSomething event, Emitter<ProfileState> emit) async {
    User? user = await userRepository.userDao.getCurrentUser(0);

    dynamic response =
        await ratingsRepository.rateSomething(user: user, rating: event.rating);
    ProfileState newState = state.copyWith(status: ProfileStatus.rated);
    emit(newState);
  }

  void _createCompanyMatch(
      CreateCompanyMatch event, Emitter<ProfileState> emit) async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    dynamic response = await companyMatchRepository.createMatchRelationship(
        user: user, relationship: event.relationship);
  }
  

  void _fetchProfileAutoLogin(
      FetchProfileAutoLogin event, Emitter<ProfileState> emit) async {
    try {
      User? user = await userRepository.userDao.getCurrentUser(0);
      Profile profile = await userRepository.getProfileFromApi(user: user!);
      ProfileState newState = state.copyWith(
          profile: profile,
          user: user,
          status: ProfileStatus.successfull,
          message: 'I have this profile');
      emit(newState);
      print('profile has been updated');
    } catch (e) {
      print(e.toString());
    }
    // emit(state.copyWith(profile: state.profile, status: ProfileStatus.failure));
  }
  
  void _fetchPaymentMethod(FetchPaymentMethod event, Emitter<ProfileState>emit)async{
    emit(state.copyWith(status: ProfileStatus.updating));
    try{
      CreditCardDetails creditCardDetails= await userRepository.fetchPaymentMethod();
      ProfileState newState = state.copyWith(paymentMethodDetails: creditCardDetails, status: ProfileStatus.successfull );
      emit(newState);
    }catch(e){
      emit(state.copyWith(status: ProfileStatus.successfull, message: e.toString()));
    }
  }

  void _addShirt(AddShirt event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      await userRepository.addShirtToProfileList(shirt: event.addedShirt);
      Profile profile =
          await userRepository.getProfileFromApi(user: state.user!);
      emit(state.copyWith(
          profile: profile,
          status: ProfileStatus.successfull,
          user: state.user!));
    } catch (e) {
      print(e.toString());
    }
  }

  void _createPaymentMethod(
      CreatePaymentMethod event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      final paymentMethodId = await userRepository.createPaymentMethod(
          cardholderName: event.cardholderName,
          cardNumber: event.cardNumber,
          expMonth: event.expMonth,
          expYear: event.expYear,
          cvv: event.cvv);
      if (paymentMethodId == null) {
        emit(state.copyWith(
            message:
                'Failed to save your payment details, please re-enter your details'));
      }
      try {
        final clientSecret = await userRepository.getSetupIntentClientSecret();
        print('the client_secret is $clientSecret');

        try {
          final setupIntent = await userRepository.confirmSetupIntent(
              paymentMethodId!, clientSecret, event.cardholderName);

          add(FetchPaymentMethod());
          
          emit(state.copyWith(status: ProfileStatus.successfull));
        } catch (e) {
          print({e.toString(): 'the setup intent was the'});
        }
        
      } catch (e) {
        print(e.toString);
      }
    } catch (error) {
      print('this is the problem');
      emit(state.copyWith(
          message: error.toString(), status: ProfileStatus.successfull));
    }
    emit(state.copyWith(status: ProfileStatus.successfull));
  }

  void _addAtrocity(AddAtrocity event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      await userRepository.addAtrocityToProfileList(atrocity: event.atrocity);
      Profile profile =
          await userRepository.getProfileFromApi(user: state.user!);
      emit(state.copyWith(profile: profile, status: ProfileStatus.successfull));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  void _addFollower(AddFollower event, Emitter<ProfileState> emit) async {
    try {
      await userRepository.manageFollowers(
        manageFollower: event.interaction,
      );
      Profile profile =
          await userRepository.fetchProfile(id: state.profile!.user!);
      ProfileState newState =
          state.copyWith(profile: profile, status: ProfileStatus.successfull);
      emit(newState);
    } catch (e) {
      e.toString();
      state.copyWith(status: ProfileStatus.failure);
    }
  }

  void _removeFollower(RemoveFollower event, Emitter<ProfileState> emit) async {
    try {
      await userRepository.manageFollowers(
        manageFollower: event.interaction,
      );
      Profile profile =
          await userRepository.fetchProfile(id: state.profile!.user!);
      ProfileState newState =
          state.copyWith(profile: profile, status: ProfileStatus.successfull);
      emit(newState);
    } catch (e) {
      e.toString();
      state.copyWith(status: ProfileStatus.failure);
    }
  }

  void _createPaymentIntentForPurchase(
      CreatePaymentIntentForPurchase event, Emitter<ProfileState> emit) async {
    try {
      final data = await userRepository.createPaymentIntentForPurchase(
          event.amount, event.shirts);
      print(data);
      emit(state.copyWith(
          status: ProfileStatus.paymentIntentCreated,
          paymentIntentData: data,
          profile: state.profile));
      print(state.toString());
      // print(newState.toString());
      // emit(newState);
      // print(newState.status);
      // print(
      //     'data:${newState.paymentIntentData!['clientSecret']['client_secret']}');

      await userRepository
          .initPaymentSheetForPurchase(state.paymentIntentData!);
      emit(state.copyWith(status: ProfileStatus.updating));

      emit(state.copyWith(
          paymentIntentData: state.paymentIntentData,
          status: ProfileStatus.paymentSheetInitalized,
          profile: state.profile,
          message: 'Still has data'));
      print(state.toString());
    } catch (e) {
      emit(state.copyWith(
          status: ProfileStatus.failure,
          message: 'Failed to create payment intent: ${e.toString()}'));
    }
  }

  void _submitQuizScore(SubmitQuizScore event, Emitter<ProfileState>emit)async{
    emit(state.copyWith(status:ProfileStatus.updating));
    try{
     String? score = await userRepository.submitQuizScore(event.quizResult);
     emit(state.copyWith(status: ProfileStatus.successfull));
    }catch(e){
      
    }
  }

  void _confirmOrder(ConfirmOrder event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.confirmingOrder));
    try {
      String? status = await userRepository
          .getOrderStatus(state.paymentIntentData!['clientSecret']['id']);
      print({"theId is": state.paymentIntentData!['clientSecret']['id']});
      print(status);
      if (status == 'true') {
        print('we are here and the payment is true');
        Profile profile =
            await userRepository.fetchProfile(id: state.profile!.user!);
        ProfileState newState = state.copyWith(
            status: ProfileStatus.paymentAccepted,
            profile: profile,
            paymentIntentData: null);
        emit(newState);
      } else if (status == "false") {
        print('im getting a false statement');
        ProfileState newState =
            state.copyWith(status: ProfileStatus.paymentError);
        emit(newState);
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ProfileStatus.paymentError));
    }
  }
  // void _initPaymentSheetForPurchase(
  //     InitPaymentSheetForPurchase event, Emitter<ProfileState> emit) async {
  //   print({"the_data is": state.paymentIntentData});
  //   try {
  //     emit(state.copyWith(status: ProfileStatus.paymentsheeInitializing));
  //     await userRepository
  //         .initPaymentSheetForPurchase(state.paymentIntentData!);
  //     emit(state.copyWith(status: ProfileStatus.paymentSheetInitalized));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         status: ProfileStatus.paymentSheetError,
  //         message: 'Failed to initialize payment sheet:${e.toString()}'));
  //   }
  // }

  void _payWithPoints(PayWithPoints event, Emitter<ProfileState> emit) async {
    print(state);
    int orderId = state.paymentIntentData!["order_id"];
    print(orderId);
    try {
      emit(state.copyWith(status: ProfileStatus.updating));
      Map<String, dynamic> response =
          await userRepository.createPaymentWithPoints(event.shirts, orderId);

      if (response.containsKey("success")) {
        ProfileState newState = state.copyWith(
            status: ProfileStatus.paymentAccepted, paymentIntentData: null);
        emit(newState);
        try {
          emit(newState.copyWith(status: ProfileStatus.updating));
          Profile profile =
              await userRepository.getProfileFromApi(user: state.user!);
          ProfileState newnew = newState.copyWith(
              profile: profile,
              status: ProfileStatus.successfull,
              paymentIntentData: null,
              message: null);
          emit(newnew);
        } catch (e) {
          emit(newState.copyWith(
              message: e.toString(), status: ProfileStatus.failure));
        }
      } else {
        emit(state.copyWith(status: ProfileStatus.paymentError));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ProfileStatus.paymentError, message: e.toString()));
    }
  }

  void _addNonProfit(AddNonProfit event, Emitter<ProfileState>emit)async{
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      await userRepository.addNonProfitToProfileList(nonprofit: event.nonProfit);
      Profile profile =
          await userRepository.getProfileFromApi(user: state.user!);
      emit(state.copyWith(profile: profile, status: ProfileStatus.successfull));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  void _makeDonationWithAltrueWallet(
      MakeDonationWithAltrueFunds event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    try {
      Map<String, dynamic> data =
          await userRepository.createPaymentWithAltrueFunds(
              event.amount, event.nonprofit, event.atrocity, event.project);

      print(data.toString());
      if (data.containsKey('success')) {
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);

        emit(state.copyWith(
            profile: profile,
            status: ProfileStatus.paymentAccepted,
            message: 'Payment accepted'));
      } else {
        emit(state.copyWith(
            status: ProfileStatus.paymentError,
            message:
                'Payment Error: Please try again or check your Altrue Funds'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ProfileStatus.paymentError,
          message:
              'Payment Error: Please try again or check your Altrue Funds'));
    }

    emit(state.copyWith(
        status: ProfileStatus.successfull, paymentIntentData: null));
  }

  void _hybridPayment(HybridPayment event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.hybridPayment));
  }

  void _hybridPaymentPoints(
      HybridPaymentPoints event, Emitter<ProfileState> emit) async {
    User? user = await userRepository.userDao.getCurrentUser(0);

    try {
      dynamic data = await userRepository.createHybridPayment(event.shirts,
          state.paymentIntentData!['order_id'], event.pointAmount!);
      if (data != null && data.containsKey('amount_remaining')) {
        print('the data is here and it has the info');
      }

      Profile profile = await userRepository.getProfileFromApi(user: user!);
      print(data['amount_remaining']);
      ProfileState newState = state.copyWith(
          profile: profile,
          paymentIntentData: data,
          status: ProfileStatus.hybridPaymentFunds);
      emit(newState);
      print(
          "the new amount is ${state.paymentIntentData!['amount_remaining']}");
      await userRepository.initPaymentSheetForPurchase(data);
      emit(newState.copyWith(status: ProfileStatus.hybridPaymentFunds));
    } catch (e) {
      print(e.toString());
    }
  }

  void _hbridPaymentFunds(
      HybridPaymentFunds event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.confirmingOrder));
    String? status = await userRepository
        .getOrderStatus(state.paymentIntentData!['clientSecret']['id']);
    print(status);
    if (status == 'True') {
      print('paymentMade');
      Profile profile =
          await userRepository.fetchProfile(id: state.profile!.user!);
      ProfileState newState = state.copyWith(
          status: ProfileStatus.paymentAccepted,
          profile: profile,
          paymentIntentData: null);
      emit(newState);
    } else if (status == 'False') {
      emit(state.copyWith(status: ProfileStatus.paymentError));
    }
  }

  void _makeDonation(
      MakeDonationWithUserFunds event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.updating));
      final Map<String, dynamic> clientSecret = await userRepository
          .creatPaymentIntentForDonation(donationData: event.donationData);
      final String stripeId = clientSecret['id'];
      emit(state.copyWith(
        paymentIntentData: clientSecret,
        status: ProfileStatus.paymentProcessing,
      ));

      await userRepository.initPaymentSheet(clientSecret);
      print('The secret to making it work is  $clientSecret');

      emit(state.copyWith(status: ProfileStatus.paymentProcessing));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: ProfileStatus.paymentError));
      emit(state.copyWith(status: ProfileStatus.successfull));
    }
  }

  void _checkDonationStatus(
      CheckDonationStatus event, Emitter<ProfileState> emit) async {
    String stripeId = state.paymentIntentData!['id'];
    print('checking donation status id is: $stripeId');

    // Initial check

    bool paymentCompleted =
        await userRepository.checkDonationStatusByStripeId(stripeId);
    print('the resuly is $paymentCompleted');
    if (paymentCompleted) {
      print('The payment is done');
      emit(state.copyWith(
          paymentIntentData: null, status: ProfileStatus.paymentAccepted));

      Profile profile = await userRepository.fetchProfile(id: state.user!.id);
      emit(state.copyWith(profile: profile, status: ProfileStatus.successfull));
      return; // Exit after successful payment check
    }

    // Wait for a short period before re-checking
    await Future.delayed(Duration(seconds: 4));

    // Second check
    paymentCompleted =
        await userRepository.checkDonationStatusByStripeId(stripeId);
    if (paymentCompleted) {
      emit(state.copyWith(
          paymentIntentData: null, status: ProfileStatus.paymentAccepted));

      Profile profile = await userRepository.fetchProfile(id: state.user!.id);
      emit(state.copyWith(profile: profile, status: ProfileStatus.successfull));
    } else {
      emit(state.copyWith(status: ProfileStatus.paymentError));
      emit(state.copyWith(status: ProfileStatus.successfull));
    }
  }

  fetchQR(Profile profile) {
    return profile.qrCode;
  }
}
