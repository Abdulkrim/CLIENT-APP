import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../widgets/rounded_text.dart';
import '../../../../../widgets/scrollable_widget.dart';

class AddDeviceDialog extends StatefulWidget {
  const AddDeviceDialog({Key? key}) : super(key: key);

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final GlobalKey _serialKey = GlobalKey();
  final GlobalKey _imeiKey = GlobalKey();

  bool _showInfoTooltip = false;

  (double infoDx, double infoDy) dxdy = (0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 500,
              height: 600,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                      padding: const EdgeInsets.all(10.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                            S.current.addDevice,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          ScrollableWidget(
                            scrollViewPadding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: ClipOval(
                                      child: FadeInImage(
                                        image: AssetImage(Assets.iconsPlaceholderImage),
                                        placeholder: AssetImage(Assets.iconsPlaceholderImage),
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                context.sizedBoxHeightExtraSmall,
                                Text(S.current.device,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                                context.sizedBoxHeightMicro,
                           /*     RoundedDropDownList(
                                    margin: EdgeInsets.zero,
                                    selectedValue:
                                        context.select<DeviceBloc, Device>((value) => value.selectedDevice),
                                    isExpanded: true,
                                    onChange: (p0) {},
                                    items: context
                                        .select<DeviceBloc, List<Device>>((value) => value.devices)
                                        .map((e) => DropdownMenuItem<Device>(
                                            value: e,
                                            child: Text(
                                              e.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(color: AppColors.black),
                                            )))
                                        .toList()),*/
                                context.sizedBoxHeightExtraSmall,
                                Text(S.current.serialNo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                                context.sizedBoxHeightMicro,
                                RoundedTextWidget(
                                  key: _serialKey,
                                  text: '23432423098888',
                                  icon: const Icon(
                                    Icons.info_rounded,
                                    color: Colors.grey,
                                  ),
                                  onIconTapped: () {
                                    dxdy = (
                                      (_serialKey.globalPaintBounds!.left + 50),
                                      (_serialKey.globalPaintBounds!.bottom - 100)
                                    );
                                    _showInfoTooltip = true;

                                    setState(() {});
                                  },
                                ),
                                context.sizedBoxHeightExtraSmall,
                                Text('IMEI No',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                                context.sizedBoxHeightMicro,
                                RoundedTextWidget(
                                  key: _imeiKey,
                                  text: '21321',
                                  icon: const Icon(
                                    Icons.info_rounded,
                                    color: Colors.grey,
                                  ),
                                  onIconTapped: () {
                                    dxdy = (
                                      (_imeiKey.globalPaintBounds!.left + 50),
                                      (_imeiKey.globalPaintBounds!.bottom - 100)
                                    );
                                    _showInfoTooltip = true;

                                    setState(() {});
                                  },
                                ),
                                context.sizedBoxHeightSmall,
                                RoundedBtnWidget(
                                  onTap: () {},
                                  btnText: S.current.addDevice,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: dxdy.$1,
            top: dxdy.$2,
            child: Visibility(
              visible: _showInfoTooltip,
              child: GestureDetector(
                onTap: () => setState(() => _showInfoTooltip = false),
                child: Container(
                  height: 200,
                  width: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0x0f000000),
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Expanded(
                        child: FadeInImage(
                          image: AssetImage(Assets.iconsPlaceholderImage),
                          placeholder: AssetImage(Assets.iconsPlaceholderImage),
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text(
                        S.current.findSerialNo,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
