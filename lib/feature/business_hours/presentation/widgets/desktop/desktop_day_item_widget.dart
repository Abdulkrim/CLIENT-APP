import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/responese/working_hours_response.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/app_status_toggle_widget.dart';


class DesktopDayTimeItemWidget extends StatefulWidget {
  const DesktopDayTimeItemWidget({super.key, required this.workTime});

  final ({WorkDay workday, List<WorkingHours> hours}) workTime;

  @override
  State<DesktopDayTimeItemWidget> createState() =>
      _DesktopDayTimeItemWidgetState();
}

class _DesktopDayTimeItemWidgetState extends State<DesktopDayTimeItemWidget> {
  late bool isSelected = widget.workTime.hours.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 3),
      child: Wrap(

        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSwitchToggle(
                currentStatus: isSelected,
                  scale: .7,
                onStatusChanged: (status) {
                  if (status) {
                    widget.workTime.hours.clear();
                    widget.workTime.hours.add(WorkingHours.empty());
                  } else {
                    widget.workTime.hours.removeWhere((element) =>
                    element.workDay?.workDayCode ==
                        widget.workTime.workday.workDayCode);
                  }
                  setState(() => isSelected = status);
                }),
            Container(
              width: 100,
              child: Text(
                widget.workTime.workday.name.capitalizeFirst!,
                style: context.textTheme.titleSmall?.copyWith(fontSize: 14,fontWeight: FontWeight.bold),
              ),
            ),
          ],),

          SizedBox(
            width: 350,
            child: Visibility(
              visible: isSelected,
              replacement: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(S.current.closed,
                    style: context.textTheme.titleSmall?.copyWith(color: AppColors.gray),),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.workTime.hours.length,
                itemBuilder: (context, index) => _TimePeriodWidget(
                  hasAddButton: index == 0,
                  time: widget.workTime.hours[index],
                  onAddTap: () {
                    widget.workTime.hours.add(WorkingHours.empty());
                    setState(() {});
                  },
                  onDeleteTap: () {
                    widget.workTime.hours.removeWhere((element) =>
                    element.id == widget.workTime.hours[index].id);

                    isSelected = widget.workTime.hours.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TimePeriodWidget extends StatefulWidget {
  const _TimePeriodWidget({
    required this.hasAddButton,
    required this.onAddTap,
    required this.onDeleteTap,
    required this.time,
  });

  final WorkingHours time;
  final bool hasAddButton;
  final Function() onAddTap;
  final Function() onDeleteTap;

  @override
  State<_TimePeriodWidget> createState() => _TimePeriodWidgetState();
}

class _TimePeriodWidgetState extends State<_TimePeriodWidget> {
  late TimeType? _selectedFromTimeType = widget.time.fromType;
  late TimeType? _selectedToTimeType = widget.time.toType;

  late final _fromTimeController =
  TextEditingController(text: widget.time.from?.substring(0, 5));
  late final _toTimeController =
  TextEditingController(text: widget.time.to?.substring(0, 5));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray2, width: .5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: InkWell(
            onTap: () async {
              TimeOfDay time = await showDialog(
                builder: (context) => TimePickerDialog(
                  initialTime: TimeOfDay.now(),
                ),
                context: context,
              );
              widget.time.from  =  _fromTimeController.text = time.format(context).substring(0,5);
              _selectedFromTimeType = _mapToTimeType(time.period);
              widget.time.fromType = _mapToTimeType(time.period);
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_fromTimeController.text),
                VerticalDivider(
                  width: .5,
                  color: AppColors.gray2,
                ),
                Text(
                  _selectedFromTimeType?.timeType ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Text(
          'to',
          style: context.textTheme.bodySmall?.copyWith(color: AppColors.gray),
        ),
        Container(
          width: 100,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray2, width: .5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: InkWell(
            onTap: () async{
              TimeOfDay time = await showDialog(
                builder: (context) => TimePickerDialog(
                  initialTime: TimeOfDay.now(),
                ),
                context: context,
              );
              _selectedToTimeType = _mapToTimeType(time.period);
              widget.time.to  =  _toTimeController.text = time.format(context).substring(0,5);
              widget.time.toType = _mapToTimeType(time.period);
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_toTimeController.text),
                VerticalDivider(
                  width: .5,
                  color: AppColors.gray2,
                ),
                Text(
                  _selectedToTimeType?.timeType ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        widget.hasAddButton
            ? IconButton(onPressed: widget.onAddTap, icon: Icon(Icons.add_circle_outline,color: AppColors.black,))
            : IconButton(
            onPressed: widget.onDeleteTap,
            icon: SvgPicture.asset(
              Assets.iconsDeleteIcon,
              width: 10,
            )),
      ],
    );
  }

  TimeType _mapToTimeType(DayPeriod p){
    if(p.index == 0) {
      return TimeType.am;
    } else {
      return  TimeType.pm;
    }
  }
}
