import 'package:flutter/cupertino.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/desktop/body_content.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/desktop/side_bar.dart';

class DesktopMainWidget extends StatelessWidget {
  const DesktopMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SideBarWidget(),
          BodyContentWidget(  ),
        ]),
      ],
    );
  }
}
