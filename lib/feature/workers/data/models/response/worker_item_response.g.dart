// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerItemResponse _$WorkerItemResponseFromJson(Map<String, dynamic> json) =>
    WorkerItemResponse(
      id: json['id'] as String?,
      total: json['total'] as num?,
      branchId: json['branchId'] as String?,
      fullName: json['fullName'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$WorkerItemResponseToJson(WorkerItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'fullName': instance.fullName,
      'isActive': instance.isActive,
      'total': instance.total,
    };
