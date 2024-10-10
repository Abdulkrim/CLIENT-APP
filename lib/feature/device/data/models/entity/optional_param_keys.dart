enum OptionalParamKeys {
  isAddressRequired('IsAddressRequired'),
  canTakeOrderViaWhatsapp('CanTakeOrderViaWhatsapp'),
  isParam1Enabled('IsParam1Enabled'),
  isParam2Enabled('IsParam2Enabled'),
  isParam3Enabled('IsParam3Enabled'),
  param1Value('Param1Value'),
  param2Value('Param2Value'),
  param3Value('Param3Value');

  const OptionalParamKeys(this.value);

  final String value;
}
