import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_text_input.dart';

import 'search_widgets/barcode_scanner_dialog.dart';

class SearchBoxWidget extends StatefulWidget {
  SearchBoxWidget({
    Key? key,
    this.hint = 'Search...',
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType,
    required this.onSearchTapped,
    this.autofocus = false,
    this.showBarcodeScanner = false,
    TextEditingController? searchTextController,
  })  : _searchTextController = searchTextController ?? TextEditingController(),
        super(key: key);

  final String hint;
  final bool autofocus;
  final Function(String? text) onSearchTapped;
  final TextInputType? keyboardType;
  late final TextEditingController _searchTextController;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool showBarcodeScanner;

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final _debounce = Debouncer(delay: const Duration(milliseconds: 800));

  bool _displayDeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    return RoundedTextInputWidget(
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
              visible: _displayDeleteIcon,
              child: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 14,
                ),
                onPressed: () {
                  widget._searchTextController.clear();
                  setState(() => _displayDeleteIcon = (widget._searchTextController.text.isNotEmpty));
                  widget.onSearchTapped('');
                },
              )),
          RoundedBtnWidget(
            height: 25,
            width: 45,
            btnText: '',
            btnIcon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 15,
            ),
            onTap: () => widget._searchTextController.text.isNotEmpty
                ? widget.onSearchTapped(widget._searchTextController.text.trim())
                : null,
          ),
          Visibility(
            visible: widget.showBarcodeScanner && !kIsWeb,
            child: RoundedBtnWidget(
              height: 25,
              width: 45,
              btnText: '',
              btnIcon: const Icon(
                Icons.camera_rounded,
                color: Colors.white,
                size: 15,
              ),
              onTap: () async {
                final barcodeText = await  Get.dialog(const BarcodeScannerDialog());
                widget._searchTextController.text=barcodeText;
                widget.onSearchTapped(barcodeText);
              }
            ),
          ),
        ],
      ),
      hintText: widget.hint,
      autofocus: widget.autofocus,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      textEditController: widget._searchTextController,
      onChange: (String text) {
        setState(() => _displayDeleteIcon = (text.isNotEmpty));

        _debounce.call(() => widget.onSearchTapped(text));
      },
      focusNode: widget.focusNode,
    );
  }
}
