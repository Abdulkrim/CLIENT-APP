import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/settings/data/repository/settings_repository.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../settings/data/models/entity/payment_type.dart';
import '../../../data/repository/customer_repository.dart';

part 'customer_payment_state.dart';

@injectable
class CustomerPaymentCubit extends Cubit<CustomerPaymentState> {
  final ICustomerRepository _customerRepository;
  final ISettingsRepository _settingsRepository;

  List<PaymentType> paymentTypes = [];

  CustomerPaymentCubit(this._customerRepository, this._settingsRepository) : super(CustomerPaymentInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState&& event.merchantInfo.hasData) {
        getBranchPaymentModeTypes();
      }
    });
  }

  void getBranchPaymentModeTypes() async {
    emit(const GetPaymentTypeStates(isLoading: true));
    final result = await _settingsRepository.getBranchSupportedPaymentTypes();

    result.fold((left) => emit(GetPaymentTypeStates(errorMessage: left.errorMessage)), (right) {
      paymentTypes = right;
      emit(const GetPaymentTypeStates(isSuccess: true));
    });
  }

  void createCustomerPayment({required String customerId}) async {
    if (paymentTypes.firstWhereOrNull(
          (element) => element.amount != 0,
        ) ==
        null) {
      emit(CreateCustomerPaymentState(errorMessage: S.current.enterAtLeastOnAmount));
      return;
    }

    final List<({int paymentModeId, num amount, String? refrenceNumber})> selectedPaymentModes = paymentTypes
        .where((element) => element.amount != 0)
        .map((e) => (paymentModeId: e.id, amount: e.amount, refrenceNumber: e.reference))
        .toList();

    emit(const CreateCustomerPaymentState(isLoading: true));

    final result =
        await _customerRepository.createCustomerPayment(customerId: customerId, selectedPaymentModes: selectedPaymentModes);
    result.fold((left) => emit(CreateCustomerPaymentState(errorMessage: left.errorMessage)),
        (right) => emit(const CreateCustomerPaymentState(isSuccess: true)));
  }
}
