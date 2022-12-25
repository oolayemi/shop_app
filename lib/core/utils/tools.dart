import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../services/utility_storage_service.dart';

String? env(name) {
  return dotenv.env[name];
}

String formatAmount(amount) {
  amount = double.parse(amount);
  return NumberFormat('#,###,###,###.###').format(amount);
}

String formatMoney(amount) {
  String nairaSymbol = '₦';
  return "$nairaSymbol${formatAmount(amount)}";
}

Dio dio({bool withToken = true}) {
  return Dio(
    BaseOptions(
      baseUrl: env('APP_URL')!,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      headers: withToken
          ? {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer ${StorageService().getString('token')}"
            }
          : {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
    ),
  );
}
