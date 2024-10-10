import 'package:equatable/equatable.dart';

class SMSNotification extends Equatable{
    bool smsAllowed;
    num smsBalance;

  SMSNotification({required this.smsAllowed,required  this.smsBalance});


    @override
  List<Object> get props => [smsAllowed , smsBalance];
}