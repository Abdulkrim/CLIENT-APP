import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../widgets/date_range_filter/widgets/start_date_picker_widget.dart';
import '../../blocs/dashboard_bloc.dart';

class MobileFloatingButtons extends StatefulWidget {
  const MobileFloatingButtons({super.key});

  @override
  State<MobileFloatingButtons> createState() => _MobileFloatingButtonsState();
}

class _MobileFloatingButtonsState extends State<MobileFloatingButtons> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: S.current.today,
          bubbleColor: Colors.white,
          titleStyle: const TextStyle(fontSize: 16, color: Colors.black),
          onPress: () {
            context.read<DashboardBloc>().add(const GetTodayDataEvent());
            _animationController!.reverse();
          },
        ),
        Bubble(
          title:S.current.week,
          bubbleColor: Colors.white,
          titleStyle: context.textTheme.titleMedium!,
          onPress: () {
            context.read<DashboardBloc>().add(const GetWeekDataEvent());
            _animationController!.reverse();
          },
        ),
        Bubble(
          title:S.current.month,
          bubbleColor: Colors.white,
          titleStyle: context.textTheme.titleMedium!,
          onPress: () {
            context.read<DashboardBloc>().add(const GetMonthDataEvent());
            _animationController!.reverse();
          },
        ),
        Bubble(
          title: S.current.dateRange,
          bubbleColor: Colors.white,
          titleStyle: context.textTheme.titleMedium!,
          onPress: () async{
           await Get.defaultDialog(
              title: '',
              content: StartDatePickerWidget(
                onFilterClick: () {
                  context.read<DashboardBloc>().add(GetRangeDataEvent(
                        _fromDateController.text.trim(),
                        _toDateController.text.trim(),
                      ));


                },
                fromDateController: _fromDateController,
                toDateController: _toDateController,
              ),
            );
            _animationController!.reverse();
          },
        ),
      ],
      animation: _animation!,
      onPress: () => _animationController!.isCompleted
          ? _animationController!.reverse()
          : _animationController!.forward(),
      backGroundColor: context.colorScheme.primaryColor,
      iconColor: Colors.white,
      iconData: Icons.calendar_month,
    );
  }
}
