import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/entity/payment_status.dart';
import '../../../data/repository/subscription_repository.dart';

part 'payment_status_state.dart';

@injectable
class PaymentStatusCubit extends Cubit<PaymentStatusState> {
  final ISubscriptionRepository _subscriptionRepository;

  PaymentStatus? paymentStatus;

  PaymentStatusCubit(this._subscriptionRepository) : super(PaymentStatusInitial());

  void checkPaymentStatus({required String payId}) async {
    emit(PaymentStatusResultState(isLoading: true));
    final result = await _subscriptionRepository.checkPaymentStatus(paymentId: payId);
    result.fold((left) => emit(PaymentStatusResultState(errorMessage: left.errorMessage)), (right) {
      paymentStatus = right;
      emit(PaymentStatusResultState(isSuccess: true));
    });
  }
}
