import 'package:equatable/equatable.dart';

class ParamObject extends Equatable {
  final String paramHeader;
  final String _isEnabled;

  bool get isEnabled => _isEnabled.toLowerCase() == 'true';

  final String paramValue;

  const ParamObject(this.paramHeader, this.paramValue, String isEnabled) : _isEnabled = isEnabled;

  @override
  List<Object> get props => [paramHeader, isEnabled, paramValue];
}
