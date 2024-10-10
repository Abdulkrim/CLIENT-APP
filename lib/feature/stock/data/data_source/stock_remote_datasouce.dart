import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/stock/data/models/params/increase_stock_parameter.dart';
import 'package:merchant_dashboard/feature/stock/data/models/response/stock_list_response.dart';
import 'package:merchant_dashboard/feature/stock/data/models/response/stock_statistics_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:universal_html/html.dart' as unversalHtml;
import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../models/params/decrease_stock_parameter.dart';
import '../models/params/download_stock_parameter.dart';
import '../models/response/change_stock_reasons_response.dart';

abstract class IStockRemoteDataSource {
  Future<StockListResponse> getAllStocks(BaseFilterListParameter stockListParameter);

  Future<StockStatisticsResponse> getStockStatistics(MerchantBranchParameter parameter);

  Future<bool> increaseStock(IncreaseStockParameter stockParameter);

  Future<bool> decreaseStock(DecreaseStockParameter parameter);

  Future<ChangeStockReasonsResponse> getStockChangeReasons();

  Future<String> getExportExcelLink([MerchantBranchParameter? parameter]);
  Future<bool> getExportExcelLinkItem(DownloadStockParameter parameter ,int itemStockId);
}

@LazySingleton(as: IStockRemoteDataSource)
class StockRemoteDataSource extends IStockRemoteDataSource {
  final Dio _dioClient;

  StockRemoteDataSource(this._dioClient);

  @override
  Future<StockStatisticsResponse> getStockStatistics(MerchantBranchParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("Stock/StockStatistics", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final StockStatisticsResponse stockResponse = StockStatisticsResponse.fromJson(response.data);
        return stockResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<StockListResponse> getAllStocks(BaseFilterListParameter stockListParameter) async {
    try {
      final Response response = await _dioClient.post("Stock/BranchStockItems",
          data: stockListParameter.filterToJson(), queryParameters: stockListParameter.branchToJson());

      if (response.statusCode == 200) {
        final StockListResponse stockResponse = StockListResponse.fromJson(response.data);
        return stockResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<ChangeStockReasonsResponse> getStockChangeReasons() async {
    try {
      final Response response = await _dioClient.get("Stock/StockChangeReasons");

      if (response.statusCode == 200) {
        return ChangeStockReasonsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> increaseStock(IncreaseStockParameter stockParameter) async {
    try {
      final Response response = await _dioClient.post("Stock/Increase", data: stockParameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> decreaseStock(DecreaseStockParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Stock/Decrease", data: parameter.toJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(
          error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<String> getExportExcelLink([MerchantBranchParameter? parameter]) async {
    try {
      final Response response = await _dioClient.get("Stock/ExportToExcel",
          queryParameters: (parameter ?? MerchantBranchParameter()).branchToJson());

      if (response.statusCode == 200) {
        return response.data;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage,
          (error.response?.statusCode ?? 0).toString());
    }
  }
  @override
  Future<bool> getExportExcelLinkItem(
DownloadStockParameter? parameter, int itemStockId) async {
    try {
     var dio =  _dioClient;
     dio.options.baseUrl = dio.options.baseUrl.replaceAll('v5', 'v4');
      final Response response = await dio.post(
        "Stock/HistoryAsExcel",
        queryParameters: {'itemStockId': itemStockId.toString()},
        data: parameter ?? {},
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        List<int> xlsxString = response.data;
          // Trigger the download of the XSL file
         await downloadXslFile(xlsxString, "Stock History.xlsx");
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage,
          (error.response?.statusCode ?? 0).toString());
    }
  }
}
Future<void> downloadXslFile(List<int> xslContent, String fileName) async {
  // Encode our file in base64
  final _base64 = base64Encode(xslContent);
  if(kIsWeb){
    // Create the link with the file
    final anchor = unversalHtml.AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
      ..target = 'blank';
    // add the name
    if (fileName != null) {
      anchor.download = fileName;
    }
    // trigger download
    unversalHtml.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
  else{
    Directory dir  = await getApplicationDocumentsDirectory();
      final String filePath = '${dir.path}/$fileName';
      final File file = File(filePath);
      await file.writeAsBytes(xslContent);
      await OpenFile.open(filePath);
  }
}