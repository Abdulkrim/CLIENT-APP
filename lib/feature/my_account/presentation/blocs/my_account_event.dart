part of 'my_account_bloc.dart';


abstract class MyAccountEvent extends Equatable {

  const MyAccountEvent();

  @override
  List<Object> get props => [];
}

class AccountSummaryRequestEvent extends MyAccountEvent {
  const AccountSummaryRequestEvent();
}

class BillingHistoryRequestEvent extends MyAccountEvent {
  const BillingHistoryRequestEvent();
}

class SubscriptionPlanRequestEvent extends MyAccountEvent {
  const SubscriptionPlanRequestEvent();
}

class GetAccountDetailsEvent extends MyAccountEvent {
  const GetAccountDetailsEvent();
}

class UpdateAccountInfoEvent extends MyAccountEvent {
  final String fieldKey;
  final String fieldValue;
  const UpdateAccountInfoEvent({required this.fieldKey, required this.fieldValue});

  @override
  List<Object> get props => [fieldKey , fieldValue];
}