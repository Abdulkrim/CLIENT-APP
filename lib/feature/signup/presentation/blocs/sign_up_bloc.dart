import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/business_type.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../core/utils/failure.dart';
import '../../data/models/params/save_signup_steps_parameter.dart';
import '../../data/repository/signup_repository.dart';
import '../widgets/desktop/desktop_signup_setup_guide_screen.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';


@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with DateTimeUtilities {

  List<BusinessType> businessTypes = [];

  final ISignUpRepository _signUpRepository;

  final SaveSignupStepsParameter saveSignupStepsParameter = SaveSignupStepsParameter();

  SignUpBloc(this._signUpRepository ) : super(SignUpInitial()) {

    on<GetAllBusinessTypesEvent>((event, emit) async {
      final Either<Failure, List<BusinessType>> result = await _signUpRepository.getBusinessTypes();
      result.fold((left) => debugPrint(left.errorMessage), (right) {
        businessTypes = right;

        emit(const GetAllBusinessTypesDataSuccessState());
      });
    });


    on<CreateBranchEvent>((event, emit) async {
      emit(const CreateBranchStates(isLoading: true));
      final Either<Failure, String> result = await _signUpRepository.addBranchInfo(
        name: event.name,
        phoneNumber: event.phoneNumber,
        email: event.email,
        branchAddress: event.branchAddress,
        businessTypeId: event.businessTypeId,
        cityId: event.selectedCityId,
        domainAddress: event.domainText,
        cityName: event.cityName,
        countryId: event.countryId,
      );
      result.fold((left) {
        debugPrint(left.errorMessage);
        emit(CreateBranchStates(error: left.errorMessage));
      }, (right) {
      /*  completedStep = GuideSteps.createBranchParameter.value;
        _signUpRepository.setGuideStepCompleted(completedStep);

        insertedBranchId = right;

        // Refresh the branches dropdown*/
        getIt<MainScreenBloc>().add(const InitalEventsCall());

        emit(const CreateBranchStates(isSuccess: true));
      });
    });

    on<ValidateBusinessName>((event, emit) async {
      if (event.isReset) {
        emit(const ValidateBusinessNameState());

        return;
      }

      emit(const ValidateBusinessNameState(isLoading: true));
      final result = await _signUpRepository.validateBusinessName(event.businessName);

      result.fold(
        (left) => emit(ValidateBusinessNameState(error: left.errorMessage)),
        (right) => right
            ? emit(const ValidateBusinessNameState(isSuccess: true))
            : emit(const ValidateBusinessNameState(error: 'This name is not available or duplicated!')),
      );
    });

    on<ValidateBusinessDomain>((event, emit) async {
      if (event.isReset) {
        emit(const ValidateBusinessDomainState(error: 'Enter a valid value'));

        return;
      }
      emit(const ValidateBusinessDomainState(isLoading: true));
      final result = await _signUpRepository.validateBusinessDomain(event.businessDomain);

      result.fold(
        (left) => emit(ValidateBusinessDomainState(error: left.errorMessage)),
        (right) => right
            ? emit(const ValidateBusinessDomainState(isSuccess: true))
            : emit(const ValidateBusinessDomainState(error: 'This domain is not available or duplicated!')),
      );
    });

    on<SaveSetupGuideData>((event, emit) async {
      emit(const SaveSetupDataState(isLoading: true));

      final result = await _signUpRepository.saveSetupGuideData(saveSignupStepsParameter);

      result.fold(
        (left) => emit(SaveSetupDataState(error: left.errorMessage)),
        (right) {
          _signUpRepository.saveHasBranch(true);
          emit(const SaveSetupDataState(isSuccess: true));
        },
      );
    });
  }

  bool canGoNext({required SignupSetupGuideStep page}) => switch (page) {
        SignupSetupGuideStep.businessType => saveSignupStepsParameter.businessTypeId != null,
        SignupSetupGuideStep.businessTypeName => saveSignupStepsParameter.businessName != null,
        SignupSetupGuideStep.domainLink => saveSignupStepsParameter.domainName != null,
        SignupSetupGuideStep.region => saveSignupStepsParameter.cityId != null && saveSignupStepsParameter.cityId != 0,
        SignupSetupGuideStep.phoneNumber => saveSignupStepsParameter.whatsappNumber != null,
        SignupSetupGuideStep.restaurantConfiguration =>
          saveSignupStepsParameter.hasKitchen != null && saveSignupStepsParameter.takeOrder != null,
        SignupSetupGuideStep.demoDataConfiguration => saveSignupStepsParameter.needDemo != null,
      };

}
