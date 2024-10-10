class OptionalParameters {
  final int id;
  final String paramValue;
  final String paramName;
  final String paramType;

  bool get flagParamValue => paramValue.toLowerCase() == 'true';

  OptionalParameters({required this.id, required this.paramValue, required this.paramName, required this.paramType});
}
