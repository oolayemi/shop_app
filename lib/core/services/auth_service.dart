import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:encrypt/encrypt.dart' as prefix0;
import 'package:observable_ish/value/value.dart';
import 'package:shop_app/core/models/check_in_data.dart';
import 'package:shop_app/core/models/nearby_store.dart';
import 'package:shop_app/core/models/store_products_response.dart';
import 'package:shop_app/core/models/user_profile.dart';
import 'package:stacked/stacked.dart';

import '../models/api_response.dart';
import '../models/sales_record.dart';
import '../utils/tools.dart';

class AuthService with ReactiveServiceMixin {

  final RxValue<List<Store>?> _listStores = RxValue<List<Store>?>([]);
  List<Store>? get listStores => _listStores.value;

  final RxValue<CheckInData?> _checkedIn = RxValue<CheckInData?>(null);
  CheckInData? get checkedIn => _checkedIn.value;

  final RxValue<List<StoreProductData>?> _storeProductData = RxValue<List<StoreProductData>?>([]);
  List<StoreProductData>? get storeProduct => _storeProductData.value;

  final RxValue<Records?> _recordSale = RxValue<Records?>(null);
  Records? get recordSale => _recordSale.value;

  final RxValue<Profile?> _profile = RxValue<Profile?>(null);
  Profile? get profile => _profile.value;

  bool _isBiometricsAvailable = false;
  bool get isBiometricsAvailable => _isBiometricsAvailable;

  var localAuth = LocalAuthentication();

  List<BiometricType> _biometricOptions = [];

  List<BiometricType> get biometricOptions => _biometricOptions;

  final iv = IV.fromLength(16);

  AuthService() {
    listenToReactiveValues([_checkedIn, _recordSale, _profile]);
  }

  static Encrypter crypt() {
    final appKey = env('APP_KEY')!;
    final key = prefix0.Key.fromBase64(appKey);
    return Encrypter(prefix0.AES(key));
  }

  dynamic encryptData(dynamic data) {
    return crypt().encrypt(data, iv: iv).base64;
  }

  dynamic decryptData(dynamic data) {
    return crypt().decrypt64(data, iv: iv);
  }

  Future<void> setBiometricStatus() async {
    _isBiometricsAvailable = await localAuth.canCheckBiometrics;
    if (isBiometricsAvailable) {
      localAuth.getAvailableBiometrics().then((value) => _biometricOptions = value);
    }
    return;
  }

  Future setCheckedIn(CheckInData checkInData) async {
    _checkedIn.value = checkInData;
    notifyListeners();
  }

  Future setCurrentStoreProducts(List<StoreProductData>? storeProduct) async {
    _storeProductData.value = storeProduct;
    notifyListeners();
  }

  Future<ApiResponse> getStores() async {
    ApiResponse response = ApiResponse(showMessage: false);

    try {
      Position position = await _determinePosition();

      var data = {'longitude': position.longitude, 'latitude': position.latitude};

      await dio().post('/user/stores/location/get', data: data).then((value) async {
        print("GET STORES RESPONSE::::");

        Map<String, dynamic> responseData = value.data!;

          if (responseData['status'] == 'success') {
            NearbyStoreResponse temp = NearbyStoreResponse.fromJson(responseData);
            _listStores.value = temp.store;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(showMessage: true, message: responseData['message']);
            return;
          }
      });
    } on DioError catch (e) {
      print(e.response!.data);
      response = ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getSales() async {
    ApiResponse response = ApiResponse(showMessage: false);
    try {

      await dio().get("/user/sale/all/${checkedIn!.id}").then((value) async {
        print("GET SALES RESPONSE::::");

        Map<String, dynamic> responseData = value.data!;

          if (responseData['status'] == 'success') {
            print(jsonEncode(responseData));
            SalesRecord salesRecord = SalesRecord.fromJson(responseData);
            _recordSale.value = salesRecord.data;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(showMessage: true, message: responseData['message']);
            return;
          }
      });
    } on DioError catch (e) {
      print(e.response!);
      response = ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<ApiResponse> getProfile() async {
    ApiResponse response = ApiResponse(showMessage: false);
    try {

      await dio().get("/user/profile").then((value) async {
        print("GET PROFILE RESPONSE::::");

        Map<String, dynamic> responseData = value.data!;

          if (responseData['status'] == 'success') {
            UserProfile userProfile = UserProfile.fromJson(responseData);
            _profile.value = userProfile.data;
            response = ApiResponse(showMessage: false, message: null);
            notifyListeners();
            return;
          } else {
            response = ApiResponse(showMessage: true, message: responseData['message']);
            return;
          }
      });
    } on DioError catch (e) {
      print(e.response!);
      response = ApiResponse(showMessage: true, message: 'Error Processing Request');
    }
    return response;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
