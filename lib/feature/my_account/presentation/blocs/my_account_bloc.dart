import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/my_account/data/models/entity/account_details.dart';
import 'package:merchant_dashboard/feature/my_account/data/repository/account_details_repository.dart';

import '../../../../injection.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';

part 'my_account_event.dart';

part 'my_account_state.dart';

@injectable
class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  String selectedValue = 'Select';
  var sortType = ['Select', 'Quantity : High to Low', 'Quantity : Low to High'];

  int selectedTab = 0;

  final IAccountDetailsRepository _accountDetailsRepository;
  AccountDetails? accountDetails;

  MyAccountBloc(this._accountDetailsRepository) : super(MyAccountInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetAccountDetailsEvent());
      }
    });


    on<AccountSummaryRequestEvent>((event, emit) {
      selectedTab = 0;
      emit(const TopTabItemSelectedState(0));
    });
    on<BillingHistoryRequestEvent>((event, emit) {
      selectedTab = 1;
      emit(const TopTabItemSelectedState(1));
    });
    on<SubscriptionPlanRequestEvent>((event, emit) {
      selectedTab = 2;
      emit(const TopTabItemSelectedState(2));
    });

    on<GetAccountDetailsEvent>((event, emit) async {
      emit(const AccountDetailsLoadingState());
      final Either<Failure, AccountDetails> result = await _accountDetailsRepository.getAllAccountDetails();

      result.fold((left) => debugPrint("accountdetails error: $left"), (right) {
        accountDetails = right;
        emit(const AccountDetailsSuccessState());
      });
    });

    on<UpdateAccountInfoEvent>((event, emit) async {
      emit(const UpdateAccountDetailsLoadingState());
      final Either<Failure, bool> result =
          await _accountDetailsRepository.updateAccountDetails(event.fieldKey, event.fieldValue);

      result.fold((left) => debugPrint("accountdetails error: $left"), (right) {
        emit(const UpdateAccountDetailsSuccessState("Updated successfully."));
        add(const GetAccountDetailsEvent());
      });
    });
  }
}
