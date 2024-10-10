import 'package:equatable/equatable.dart';

class OfferType extends Equatable{
  final int offerTypeId;
  final String offerTypeName;

  const OfferType(this.offerTypeId, this.offerTypeName);

  @override
  List<Object> get props => [offerTypeId, offerTypeName];
}