import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/notifications/data/models/entity/notification_keyword.dart';
import 'package:merchant_dashboard/feature/notifications/data/models/entity/notification_type.dart';
import 'package:merchant_dashboard/feature/notifications/data/models/entity/text_notification.dart';
import 'package:merchant_dashboard/feature/notifications/presentation/blocs/notifications_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../widgets/rounded_dropdown_list.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../../../widgets/tooltip_widget.dart';
import '../../data/models/entity/notification_event.dart';

class NotificationDetailsDialogWidget extends StatefulWidget {
  const NotificationDetailsDialogWidget({super.key, this.textNotification});

  final TextNotification? textNotification;

  @override
  State<NotificationDetailsDialogWidget> createState() => _NotificationDetailsDialogWidgetState();
}

class _NotificationDetailsDialogWidgetState extends State<NotificationDetailsDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  late final _textController = TextEditingController(text: widget.textNotification?.text ?? '');

  NotificationType? _selectedNotificationType;
  NotificationEvent? _selectedNotificationEvent;

  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  _appendText(String text) {
    _textController.text = '${_textController.text} $text ';
    _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
    _textFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      width: !context.isPhone ? 400 : null,
      height: !context.isPhone ? 650 : null,
      title: '${widget.textNotification == null ? 'Add' : 'Edit'} Notification',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ScrollableWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  children: [
                    TooltipWidget(text: S.current.notificationTypeTooltip),
                    Text(S.current.notificationType),
                  ],
                ),
                const SizedBox(height: 8),
                if (context.select<NotificationsBloc, List<NotificationType>>((bloc) => bloc.notificationTypes).isNotEmpty)
                  CupertinoSlidingSegmentedControl(
                    children: {
                      for (var element in context.read<NotificationsBloc>().notificationTypes)
                        element: Text(element.notificationTypeName)
                    },
                    groupValue: _selectedNotificationType ??
                        () {
                          _selectedNotificationType = widget.textNotification == null
                              ? context.read<NotificationsBloc>().notificationTypes.first
                              : context.read<NotificationsBloc>().notificationTypes.firstWhere(
                                    (element) => element.notificationTypeId == widget.textNotification!.notificationTypeId,
                                  );
                          return _selectedNotificationType;
                        }.call(),
                    onValueChanged: (value) => setState(() => _selectedNotificationType = value),
                  ),
                context.sizedBoxHeightExtraSmall,
                Wrap(
                  children: [
                    TooltipWidget(text: S.current.notificationEventTooltip),
                    Text(S.current.notificationEvent),
                  ],
                ),
                const SizedBox(height: 8),
                RoundedDropDownList(
                    margin: EdgeInsets.zero,
                    selectedValue: _selectedNotificationEvent ??
                        () {
                          _selectedNotificationEvent = widget.textNotification == null
                              ? context.read<NotificationsBloc>().notificationEvents.first
                              : context.read<NotificationsBloc>().notificationEvents.firstWhere(
                                  (element) => element.notificationEventId == widget.textNotification!.notificationEventId);

                          return _selectedNotificationEvent;
                        }.call(),
                    validator: (p0) => ((p0 as NotificationEvent).notificationEventId == '0') ? 'Select an Event' : null,
                    isExpanded: true,
                    onChange: (p0) => setState(() => _selectedNotificationEvent = p0),
                    items: context
                        .select<NotificationsBloc, List<NotificationEvent>>((NotificationsBloc bloc) => bloc.notificationEvents)
                        .map((e) => DropdownMenuItem<NotificationEvent>(
                            value: e,
                            child: Text(
                              e.notificationEventName,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                            )))
                        .toList()),
                context.sizedBoxHeightExtraSmall,
                Wrap(
                  children: [
                    TooltipWidget(text: S.current.notificationTextTooltip),
                    Text(S.current.text),
                  ],
                ),
                context.sizedBoxHeightMicro,
                RoundedTextInputWidget(
                  hintText: "Text",
                  focusNode: _textFocusNode,
                  textEditController: _textController,
                  minLines: 4,
                  maxLines: 4,
                  isRequired: true,
                  maxLength: -1,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ScrollableWidget(
                    child: Wrap(
                        children: context
                            .select<NotificationsBloc, List<NotificationKeyWord>>((bloc) => bloc.notificationKeyWords)
                            .map((e) => AppInkWell(
                                  onTap: () {
                                    _appendText(e.keyword);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: context.colorScheme.primaryColorLight,
                                      ),
                                    ),
                                    child: Text(
                                      e.title,
                                      style: context.textTheme.bodyMedium?.copyWith(),
                                    ),
                                  ),
                                ))
                            .toList()),
                  ),
                ),
                context.sizedBoxHeightSmall,
                Row(
                  children: [
                    Expanded(
                      child: RoundedBtnWidget(
                        onTap: () => Get.back(),
                        btnText: "Cancel",
                        btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        bgColor: AppColors.white,
                        boxBorder: Border.all(color: AppColors.black),
                        btnTextColor: AppColors.black,
                      ),
                    ),
                    Expanded(
                        child: BlocConsumer<NotificationsBloc, NotificationsState>(
                      listener: (context, state) {
                        switch (state) {
                          case AddNotificationsStates() when state.successMessage != null:
                            Get.back();
                            context.showCustomeAlert(state.successMessage!, SnackBarType.success);
                          case AddNotificationsStates() when state.errorMessage != null:
                            context.showCustomeAlert(state.errorMessage!, SnackBarType.error);
                          default:
                            {}
                        }
                      },
                      builder: (context, state) => (state is AddNotificationsStates)
                          ? const LoadingWidget()
                          : RoundedBtnWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.textNotification == null) {
                                    context.read<NotificationsBloc>().add(AddNotificationEvent(
                                        notificationType: _selectedNotificationType!.notificationTypeId,
                                        notificationEvent: _selectedNotificationEvent!.notificationEventId,
                                        text: _textController.text.trim()));
                                  } else {
                                    context.read<NotificationsBloc>().add(EditNotificationEvent(
                                        notificationId: widget.textNotification!.notificationBaseID,
                                        notificationType: _selectedNotificationType!.notificationTypeId,
                                        notificationEvent: _selectedNotificationEvent!.notificationEventId,
                                        text: _textController.text.trim()));
                                  }
                                }
                              },
                              btnText: S.current.save,
                              btnPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
