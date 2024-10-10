
import 'package:equatable/equatable.dart';

class NotificationType extends Equatable{
 final String notificationTypeId;
 final String notificationTypeName;

  const NotificationType({required this.notificationTypeId,required this.notificationTypeName});



 @override
  List<Object> get props => [notificationTypeId, notificationTypeName];
}
