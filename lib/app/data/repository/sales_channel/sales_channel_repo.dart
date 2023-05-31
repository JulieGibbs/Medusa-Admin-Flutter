import 'package:medusa_admin/app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:medusa_admin/app/data/models/req/user_sales_channel_req.dart';
import 'package:medusa_admin/app/data/models/res/sales_channel_res.dart';
import 'package:multiple_result/multiple_result.dart';
import 'base_sales_channel.dart';
import 'package:dio/dio.dart';
import '../../datasource/remote/dio/dio_client.dart';
class SalesChannelRepo extends BaseSalesChannel {
  final _dataProvider = DioClient(dio: Dio());

  @override
  Future<Result<UserAddProductsToSalesChannelRes, Failure>> addProductsToSalesChannel({
    required String id,
    required List<String> productIds,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      var data = <Map<String, dynamic>>[];
      for (var id in productIds) {
        data.add({'id': id});
      }
      final response = await _dataProvider.post(uri: '/sales-channels/$id/products/batch', data: {
        'product_ids': data,
      });
      if (response.statusCode == 200) {
        return Success(UserAddProductsToSalesChannelRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserAssociateStockLocationToSalesChannelRes, Failure>> associateStockLocationToSalesChannel({
    required String id,
    required String locationId,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.post(uri: '/sales-channels/$id/stock-locations', data: {
        'location_id': locationId,
      });
      if (response.statusCode == 200) {
        return Success(UserAssociateStockLocationToSalesChannelRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserCreateSalesChannelRes, Failure>> create({
    required UserSalesChannelCreateReq userSalesChannelCreateReq,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.post(
        uri: '/sales-channels',
        data: userSalesChannelCreateReq.toJson(),
      );
      if (response.statusCode == 200) {
        return Success(UserCreateSalesChannelRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserSalesChannelDeleteRes, Failure>> delete({
    required String id,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.delete(
        '/sales-channels/$id',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserSalesChannelDeleteRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserRemoveProductsFromSalesChannelRes, Failure>> removeProductsFromSalesChannel({
    required String id,
    required List<String> productIds,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      var data = <Map<String, dynamic>>[];
      for (var id in productIds) {
        data.add({'id': id});
      }
      final response = await _dataProvider.delete(
        '/sales-channels/$id/products/batch',
        data: {
          'product_ids': data,
        },
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserRemoveProductsFromSalesChannelRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserRemoveStockLocationFromSalesChannelRes, Failure>> removeStockLocationFromSalesChannel({
    required String id,
    required String locationId,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.delete(
        '/sales-channels/$id/stock-locations',
        data: {
          'location_id': locationId,
        },
      );
      if (response.statusCode == 200) {
        return Success(UserRemoveStockLocationFromSalesChannelRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserSalesChannelRetrieveRes, Failure>> retrieve({
    required String id,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.get(
        uri: '/sales-channels/$id',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserSalesChannelRetrieveRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserSalesChannelRetrieveAllRes, Failure>> retrieveAll({
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.get(
        uri: '/sales-channels',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserSalesChannelRetrieveAllRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserRetrieveStockLocationsRes, Failure>> retrieveStockLocations({
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.get(
        uri: '/stock-locations',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserRetrieveStockLocationsRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }

  @override
  Future<Result<UserSalesChannelUpdateRes, Failure>> update({
    required String id,
    required UserSalesChannelUpdateReq userSalesChannelUpdateRes,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dataProvider.dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dataProvider.post(
        uri: '/sales-channels/$id',
        data: userSalesChannelUpdateRes.toJson(),
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return Success(UserSalesChannelUpdateRes.fromJson(response.data));
      } else {
        return Error(Failure.from(response));
      }
    } catch (e) {
      return Error(Failure.from(e));
    }
  }
}
