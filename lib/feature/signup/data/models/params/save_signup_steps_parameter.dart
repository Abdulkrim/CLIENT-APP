import 'package:flutter/widgets.dart';

import '../../../../../core/utils/configuration.dart';
import '../../../../../injection.dart';

class SaveSignupStepsParameter {
  var doneSteps = ValueNotifier(false);

  int? _businessTypeId;

  int? get businessTypeId => _businessTypeId;

  set businessTypeId(int? value) {
    _businessTypeId = value;

    doneSteps.value = true;
  }

  String? _businessName;

  String? get businessName => _businessName;

  set businessName(String? value) {
    _businessName = value;

    doneSteps.value = (_businessName != null && businessName!.isNotEmpty);
  }

  String? _domainName;

  String? get domainName => _domainName;

  set domainName(String? value) {
    _domainName = value;

    doneSteps.value = (_domainName != null && _domainName!.isNotEmpty);
  }

  int? _countryId;

  int? get countryId => _countryId;

  set countryId(int? value) {
    _countryId = value;
  }

  int? _cityId;

  int? get cityId => _cityId;

  set cityId(int? value) {
    _cityId = value;

    if (_cityId != null && _cityId != 0) doneSteps.value = true;
  }

  String? _whatsappNumber;

  String? get whatsappNumber => _whatsappNumber;

  set whatsappNumber(String? value) {
    _whatsappNumber = value;

    if (_whatsappNumber != null && _whatsappNumber!.isNotEmpty) doneSteps.value = true;
  }

  bool _takeOrder = false;

  bool? get takeOrder => _takeOrder;

  set takeOrder(bool? value) {
    _takeOrder = value ?? false;

    doneSteps.value = true;
  }

  bool _hasKitchen = false;

  bool? get hasKitchen => _hasKitchen;

  set hasKitchen(bool? value) {
    _hasKitchen = value ?? false;
    doneSteps.value = true;
  }

  resetKitchenSetup() {
    hasKitchen = false;
    takeOrder = false;
  }

  bool? _needDemo;

  bool? get needDemo => _needDemo;

  set needDemo(bool? value) {
    _needDemo = value;
    if (_needDemo != null) doneSteps.value = true;
  }

  SaveSignupStepsParameter();

  Map<String, dynamic> toJson() => {
        'businessTypeId': _businessTypeId,
        'name': _businessName,
        'domainAddress': '$_domainName.${getIt<Configuration>().branchUrl}',
        'cityId': _cityId,
        'whatssAppNumber': '+$_whatsappNumber',
        'isDefinedWaiter': _takeOrder,
        'isDefinedKitchen': _hasKitchen,
        'useDemoData': _needDemo,
      };
}
