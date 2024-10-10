import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/notifications/data/models/entity/sms_notification.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../data/models/entity/notification_event.dart';
import '../../data/models/entity/notification_keyword.dart';
import '../../data/models/entity/notification_type.dart';
import '../../data/models/entity/text_notification.dart';
import '../../data/repository/notifications_repository.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final INotificationsRepository _notificationsRepository;

  List<TextNotification> textNotifications = [];

  List<NotificationType> notificationTypes = [];
  List<NotificationEvent> notificationEvents = [const NotificationEvent.firstItem()];
  List<NotificationKeyWord> notificationKeyWords = [];

  SMSNotification? smsNotification ;

  NotificationsBloc(this._notificationsRepository) : super(NotificationsInitial()) {
    getIt<MainScreenBloc>().stream.where((state) => state is MerchantInfoSelectionChangedState).take(1).listen((state) {
      add(const GetAllSavedNotifications());
    });

    on<GetNotificationSettings>((event, emit) async {
      emit(const GetNotificationSettingsStates(isLoading: true));
      final result = await _notificationsRepository.getSMSNotificationSettings( );

      result.fold((left) {
        emit(GetNotificationSettingsStates(errorMessage: left.errorMessage));
      }, (right) {
        smsNotification  = right;
        emit(const GetNotificationSettingsStates(isSuccess:  true));
      });
    });

    on<UpdateNotificationSettings>((event, emit) async {
      emit(const UpdateNotificationSettingsStates(isLoading: true));
      final result = await _notificationsRepository.updateNotificationSettings( event.isSmsAllowed);

      result.fold((left) {
        emit(UpdateNotificationSettingsStates(errorMessage: left.errorMessage));
      }, (right) {
        smsNotification?.smsAllowed  = event.isSmsAllowed;

        emit(const UpdateNotificationSettingsStates(isSuccess:  true));
      });
    });

    on<AddNotificationEvent>((event, emit) async {
      emit(const AddNotificationsStates(isLoading: true));
      final result = await _notificationsRepository.addSMSNotification(
          notificationType: event.notificationType, notificationEvent: event.notificationEvent, text: event.text);

      result.fold((left) {
        debugPrint(left.errorMessage);
        emit(AddNotificationsStates(errorMessage: left.errorMessage));
      }, (right) {
        emit(const AddNotificationsStates(successMessage: 'Notification added successfully.'));

        add(const GetAllSavedNotifications());
      });
    });

    on<GetAllSavedNotifications>((event, emit) async {
      emit(const GetNotificationsStates(isLoading: true));
      final result = await _notificationsRepository.getSavedNotifications();
      result.fold((left) => debugPrint(left.errorMessage), (right) {
        textNotifications = right;

        emit(const GetNotificationsStates(isSuccess: true));
      });
    });

    on<EditNotificationEvent>((event, emit) async {
      emit(const AddNotificationsStates(isLoading: true));
      final result = await _notificationsRepository.editNotifications(
          notificationId: event.notificationId,
          notificationType: event.notificationType,
          notificationEvent: event.notificationEvent,
          text: event.text);

      result.fold((left) {
        debugPrint(left.errorMessage);
        emit(AddNotificationsStates(errorMessage: left.errorMessage));
      }, (right) {
        emit(const AddNotificationsStates(successMessage: 'Notification edited successfully.'));
        add(const GetAllSavedNotifications());
      });
    });

    on<DeleteNotificationEvent>((event, emit) async {
      emit(const DeleteNotificationsStates(isLoading: true));
      final result = await _notificationsRepository.deleteNotifications(event.notificationId);

      result.fold((left) => debugPrint(left.errorMessage), (right) {
        emit(const DeleteNotificationsStates(isSuccess: true));

        add(const GetAllSavedNotifications());
      });
    });

    on<GetNotificationKeyWords>((event, emit) async {
      final result = await _notificationsRepository.getNotificationKeyWords();

      result.fold(
        (left) => debugPrint(left.errorMessage),
        (right) {
          notificationKeyWords = right;
        },
      );
    });

    on<GetAllNotificationTypeEvent>((event, emit) async {
      final result = await _notificationsRepository.getNotificationTypes();
      result.fold((left) => debugPrint(left.errorMessage), (right) {
        notificationTypes = [...right];
      });
    });

    on<GetAllNotificationEventsEvent>((event, emit) async {
      final result = await _notificationsRepository.getNotificationEvents();
      result.fold((left) => debugPrint(left.errorMessage), (right) {
        notificationEvents = [const NotificationEvent.firstItem(), ...right];
      });
    });
  }
}
