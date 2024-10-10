import '../../entity/offer_type.dart';

class OffersResponse{
  List<OfferItemResponse>? offers;

  OffersResponse(this.offers);

  OffersResponse.fromJson(List<dynamic>? json): offers = json?.map((e) => OfferItemResponse.fromJson(e)).toList()?? [];

  List<OfferType> toEntity() => offers?.map((e) => OfferType(e.offerTypeId ?? 0, e.offerTypeName ?? '-')).toList() ?? [];

}

class OfferItemResponse {
  int? offerTypeId;
  String? offerTypeName;

  OfferItemResponse({this.offerTypeId, this.offerTypeName});

  OfferItemResponse.fromJson(Map<String, dynamic> json) {
    offerTypeId = json['offerTypeId'];
    offerTypeName = json['offerTypeName'];
  }

}