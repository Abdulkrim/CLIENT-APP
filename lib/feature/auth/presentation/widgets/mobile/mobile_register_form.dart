// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:merchant_dashboard/feature/auth/presentation/blocs/login_bloc.dart';
// import 'package:merchant_dashboard/generated/assets.dart';
// import 'package:merchant_dashboard/generated/l10n.dart';
// import 'package:merchant_dashboard/utils/extensions/extensions.dart';
// import 'package:merchant_dashboard/utils/mixins/mixins.dart';
// import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
//
// import '../../../../../core/utils/validations/validation.dart';
// import '../../../../../core/utils/validations/validator.dart';
// import '../../../../../utils/snack_alert/snack_alert.dart';
// import '../../../../../widgets/loading_widget.dart';
// import '../../../../../widgets/rounded_btn.dart';
// import '../register_congrats_dialog.dart';
//
// class MobileRegisterFormWidget extends StatefulWidget {
//   const MobileRegisterFormWidget({super.key, required this.onLoginFormTapped});
//
//   final Function onLoginFormTapped;
//
//   @override
//   State<MobileRegisterFormWidget> createState() => _MobileRegisterFormState();
// }
//
// class _MobileRegisterFormState extends State<MobileRegisterFormWidget>  {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _username = TextEditingController();
//
//   final TextEditingController _userEmail = TextEditingController();
//   final TextEditingController _userPhone = TextEditingController();
//
//   final TextEditingController _userBusinessName = TextEditingController();
//
//   final TextEditingController _password = TextEditingController();
//
//   bool _obscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           context.sizedBoxHeightDefault,
//           Text(
//             S.current.signUp,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineMedium
//                 ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           context.sizedBoxHeightExtraSmall,
//           TextFormField(
//             controller: _username,
//             decoration: InputDecoration(
//               hintText: S.current.userName,
//               hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
//               icon: SvgPicture.asset(Assets.iconsUserIcon),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return S.current.userNameIsRequired;
//               }
//               // You can add more validation rules here.
//               return null; // Return null if the input is valid.
//             },
//           ),
//           context.sizedBoxHeightMicro,
//           TextFormField(
//             controller: _userEmail,
//             decoration: InputDecoration(
//               hintText: S.current.emailAddress,
//               hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
//               icon: SvgPicture.asset(Assets.iconsEmail),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return S.current.emailIsRequired;
//               }
//               // You can add more validation rules here.
//               return null; // Return null if the input is valid.
//             },
//           ),
//           context.sizedBoxHeightMicro,
//           TextFormField(
//             controller: _userPhone,
//             decoration: InputDecoration(
//               hintText: '+971123456789',
//               hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
//               icon: SvgPicture.asset(Assets.iconsPhone),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return S.current.phoneIsRequired;
//               }
//               // You can add more validation rules here.
//               return null; // Return null if the input is valid.
//             },
//           ),
//           context.sizedBoxHeightMicro,
//           TextFormField(
//             controller: _userBusinessName,
//             decoration: InputDecoration(
//               hintText: S.current.businessName,
//               hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
//               icon: SvgPicture.asset(Assets.iconsShop),
//             ),
//           ),
//           context.sizedBoxHeightMicro,
//           TextFormField(
//             controller: _password,
//             obscureText: _obscurePassword,
//             decoration: InputDecoration(
//               hintText: S.current.password,
//               hintStyle: context.textTheme.labelLarge?.copyWith(color: Colors.grey),
//               icon: SvgPicture.asset(Assets.iconsLock),
//               suffixIcon: AppInkWell(
//                   onTap: () => setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       }),
//                   child: Padding(
//                     padding: const EdgeInsets.all(13.0),
//                     child: SvgPicture.asset(Assets.iconsEye),
//                   )),
//             ),
//
//             validator: Validator.apply(context, [PasswordValidation()]),
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//           ),
//           context.sizedBoxHeightSmall,
//           BlocConsumer<LoginBloc, LoginState>(
//             listener: (context, state) {
//               if (state is RegisterRequestState) {
//                 if (state.isSuccess) {
//                   Get.dialog(RegisterCongratsWidget(
//                     onTap: () {
//                       Get.back();
//                       widget.onLoginFormTapped();
//                     },
//                   ));
//                 } else if (state.errorMessage != null) {
//                   context.showCustomeAlert(state.errorMessage, SnackBarType.error);
//                 }
//               }
//             },
//             builder: (context, state) => state is RegisterRequestState && state.isLoading
//                 ? const LoadingWidget()
//                 : RoundedBtnWidget(
//                     onTap: () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<LoginBloc>().add(RegisterRequestEvent(
//                             username: _username.text.trim(),
//                             phone: _userPhone.text.trim(),
//                             email: _userEmail.text.trim(),
//                             businessName: _userBusinessName.text.trim(),
//                             password: _password.text.trim()));
//                       }
//                     },
//                     btnText: S.current.signUp,
//                     height: 45,
//                     btnTextStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//           ),
//           context.sizedBoxHeightMicro,
//           InkWell(
//             onTap: () => widget.onLoginFormTapped(),
//             child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(children: [
//                   TextSpan(
//                     text: S.current.alreadyExisting,
//                     style: context.textTheme.titleMedium,
//                   ),
//                   TextSpan(
//                     text: S.current.login,
//                     style: context.textTheme.titleMedium?.copyWith(
//                       color: context.colorScheme.primaryColor,
//                     ),
//                   ),
//                 ])),
//           ),
//         ],
//       ),
//     );
//   }
// }
