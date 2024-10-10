import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class UpdateMerchantLogoParameter extends MerchantBranchParameter {
  final int logoTypeId;
  final String filename;
  final String fileMime;
  final Uint8List byte;

  UpdateMerchantLogoParameter({required this.logoTypeId, required this.filename, required this.fileMime, required this.byte});

  FormData toFormData() => FormData.fromMap({
        'File': MultipartFile.fromBytes(byte, filename: filename, contentType: MediaType('image', '*')),
        'ImageName': filename,
        'ImageTypeId': logoTypeId,
        ...?super.branchToJson(),
      });

  Map<String, dynamic> toLogoJson() => {
        'Logo': MultipartFile.fromBytes(byte, filename: filename, contentType: MediaType('image', '*')),
        'ImageType': logoTypeId
      };
}
