import 'package:flutter/material.dart';

class ScrollableWidget extends StatefulWidget {
  final bool showAlwaysScrollbar;
  final Widget child;
  final EdgeInsetsGeometry scrollViewPadding;
  final ScrollController? scrollController;
  final bool isListView;

  const ScrollableWidget({
    Key? key,
    this.showAlwaysScrollbar = true,
    this.scrollViewPadding = const EdgeInsets.all(0),
    required this.child,
    this.isListView = false,
    this.scrollController,
  }) : super(key: key);

  @override
  State<ScrollableWidget> createState() => _ScrollableWidgetState();
}

class _ScrollableWidgetState extends State<ScrollableWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    debugPrint("initialize scrollcontroller again");
    _scrollController = widget.scrollController ?? ScrollController();
  }

/*  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    debugPrint("Scrollable widget dispose now");
  }*/
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: widget.showAlwaysScrollbar,
        controller:(widget.child is! ListView) ?  _scrollController: null,
        child: (widget.child is! ListView)
            ? SingleChildScrollView(
                controller: _scrollController,
                primary: false,
                padding: widget.scrollViewPadding,
                child: widget.child,
              )
            : widget.child);
  }
}
