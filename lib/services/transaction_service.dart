import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/transaction_model.dart';
import 'package:digium/models/transaction_pagination_model.dart';
import 'package:digium/services/dio_service.dart';
import 'package:digium/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

const _h = "[TRANSACTION SERVICE]";

class TransactionService {
  final _networkLocator = getIt.get<DioClient>();

  Future<TransactionPaginationModel> getTransactions({
    int? page = 1,
    int? paginate = 10,
  }) async {
    try {
      Map<String, dynamic> params = {
        'page': page ?? 1,
        'paginate': paginate ?? 10,
      };

      final response = await _networkLocator.dio.get(
        transactionListEndpoint,
        queryParameters: params,
      );
      var res = response.data['data'];
      TransactionPaginationModel transactions =
          TransactionPaginationModel.fromJson(res);

      return transactions;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<TransactionModel> getTransactionItems({
    required int transactionId,
  }) async {
    try {
      final response = await _networkLocator.dio.get(
        "$transactionListEndpoint/$transactionId",
      );
      var res = response.data['data'];
      TransactionModel? transactions = TransactionModel.fromJson(res);
      return transactions;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var dioException = e as DioError;
        final result = dioException.response!;
        logError(_h, result.data.toString());

        throw Exception("Internal Server Error");
      }
      logError(_h, e.toString());
      throw Exception("Something wrong");
    }
  }

  Future<void> uploadReceipt({
    required int transactionId,
    required XFile file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "receipt": await MultipartFile.fromFile(file.path, filename: file.name),
      });
      await _networkLocator.dio.post(
        "$transactionReceiptEndpoint/$transactionId",
        data: formData,
      );
    } catch (e) {
      logError(_h, e.toString());
      rethrow;
    }
  }
}
