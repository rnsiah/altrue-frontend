import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/non_profit_model.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/nonProfit_repository.dart';
import 'package:lovelovelove/Data%20Layer/Repositories/user_repository.dart';

import '../../../form_submission_status.dart';

part 'nonprofitsignup_event.dart';
part 'nonprofitsignup_state.dart';

class NonprofitsignupBloc
    extends Bloc<NonprofitsignupEvent, NonprofitsignupState> {
  NonProfitRespository nonProfitRespository = NonProfitRespository();
  UserRepository userRepository = UserRepository();

  NonprofitsignupBloc() : super(NonprofitsignupState());
  Stream<NonprofitsignupState> mapEventToState(
      NonprofitsignupEvent event) async* {
    if (event is NonProfitAddressChangeOnForm) {
      yield state.copyWith(address: event.npAddress);
    } else if (event is NonProfitDescriptionChangeOnForm) {
      yield state.copyWith(description: event.npDescription);
    } else if (event is NonProfitFacebookChangeOnForm) {
      yield state.copyWith(facebook: event.npFacebook);
    } else if (event is NonProfitInstagramChangeOnForm) {
      yield state.copyWith(instagram: event.npInstagram);
    } else if (event is NonProfitMissionStatementChangeOnForm) {
      yield state.copyWith(missionStatement: event.npMission);
    } else if (event is NonProfitNameChangeOnForm) {
      yield state.copyWith(name: event.npName);
    } else if (event is NonProfitStateChangeOnForm) {
      yield state.copyWith(state: event.npState);
    } else if (event is NonProfitVisionStatementChangeOnForm) {
      yield state.copyWith(visionStatement: event.npVision);
    } else if (event is NonProfitWebsiteChangeOnForm) {
      yield state.copyWith(website: event.npWebsite);
    } else if (event is NonProfitYearStartedChangeOnForm) {
      yield state.copyWith(yearStarted: event.npYearStarted);
    } else if (event is NonProfitSignUpFormCompletion) {
      yield state.copyWith(status: FormSubmitting());
      try {
        User? user = await userRepository.userDao.getCurrentUser(0);

        NonProfitCompletion nonprofit = NonProfitCompletion(
          website: state.website,
          profile: event.profile,
          instagram: state.instagram,
          name: state.name,
          description: state.description,
          facebook: state.facebook,
          missionStatement: state.missionStatement,
          visionStatement: state.visionStatement,
          yearStarted: state.yearStarted!,
        );
        bool created = await nonProfitRespository.newNonProfit(
            nonprofit: nonprofit, user: user!);
        if (created == true) {
          yield state.copyWith(status: SubmissionSuccess());
        }
      } catch (e) {
        yield state.copyWith(status: SubmissionFaiiled(e.toString()));
        print(e.toString());
      }
    }
  }
}


// class NonprofitsignupBloc
//     extends Bloc<NonprofitsignupEvent, NonprofitsignupState> {
//   NonprofitsignupBloc() : super(NonprofitsignupState()) {
    
//     @override
//     Stream<NonprofitsignupState> mapEventToState(
//       NonprofitsignupEvent event,
//     ) async* {
//       if (event is NonProfitAddressChangeOnForm) {
//         yield state.copyWith(address: event.npAddress);
//       }
//     }
//   }
// }
