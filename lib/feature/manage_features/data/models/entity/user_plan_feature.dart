import 'package:equatable/equatable.dart';

class UserPlanFeature extends Equatable {
  final int featureId;
  final String defaultName;
  final String fkey;

  const UserPlanFeature({
    required this.featureId,
    required this.defaultName,
    required this.fkey,
  });

  @override
  List<Object> get props => [featureId, defaultName, fkey];
}
