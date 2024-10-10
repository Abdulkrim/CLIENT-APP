// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:merchant_dashboard/utils/extensions/extensions.dart';
//
// import '../../../../../generated/l10n.dart';
// import '../../blocs/products/products_bloc.dart';
// import '../easy_autocomplete/easy_autocomplete.dart';
//
//
// class ProductNameSuggestionsWidget extends StatefulWidget {
//   const ProductNameSuggestionsWidget({super.key , required this.name});
//   final String name;
//
//   @override
//   State<ProductNameSuggestionsWidget> createState() => _ProductNameSuggestionsWidgetState();
// }
//
// class _ProductNameSuggestionsWidgetState extends State<ProductNameSuggestionsWidget> {
//
//   late final _productNameEnController = TextEditingController(text: widget.name);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text('${S.current.productEngName}*',
//             style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         EasyAutocomplete(
//           controller: _productNameEnController,
//           decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: BorderSide(
//                 color: context.colorScheme.primaryColor,
//               ),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(
//                 color: Color(0xffeeeeee),
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(
//                 color: Color(0xffeeeeee),
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(
//                 color: Color(0xffeeeeee),
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6),
//               borderSide: const BorderSide(
//                 color: Colors.redAccent,
//               ),
//             ),
//           ),
//           asyncSuggestions: (searchValue) async {
//             if (searchValue.length > 1) {
//               return await context.read<ProductsBloc>().getSuggestionItems(searchValue);
//             }
//             return [];
//           },
//           progressIndicatorBuilder: const CupertinoActivityIndicator(),
//           onSubmitted: (p0) {
//             context.read<ProductsBloc>().add(GetItemSuggestionsImage(p0));
//           },
//         )
//       ],
//     );
//   }
// }
