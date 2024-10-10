part of 'my_account_bloc.dart';


abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class TopTabItemSelectedState extends MyAccountState {
  final int pos;

  const TopTabItemSelectedState(this.pos);

  @override
  List<Object> get props => [pos];
}

class AccountDetailsSuccessState extends MyAccountState {
  const AccountDetailsSuccessState();
}

class AccountDetailsLoadingState extends MyAccountState {
  const AccountDetailsLoadingState();
}

class UpdateAccountDetailsLoadingState extends MyAccountState {
  const UpdateAccountDetailsLoadingState();
}

class UpdateAccountDetailsSuccessState extends MyAccountState {
  final String message;
  const UpdateAccountDetailsSuccessState(this.message);

  @override
  List<Object> get props => [message];
}