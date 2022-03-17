import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HomePageManager {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  static const urlPrefix = 'http://localhost:5000';

  Future<void> makeGetUserRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    const uId="6230f4e56533456d85efa902"; //replace it with user ID from your data
    final url = Uri.parse('$urlPrefix/user/'+uId);
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  Future<void> makeGetTransactionsRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    const walletId="6230f4e56533456d85efa900"; //replace it with wallet address from your data
    final url = Uri.parse('$urlPrefix/showTransactions/'+walletId);
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }



  Future<void> makeGetScheduledTransactionsRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    const walletId="6230f4e56533456d85efa900"; //replace it with wallet address from your data
    final url = Uri.parse('$urlPrefix/showScheduledTransactions/'+walletId);
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }


    Future<void> makePostRegisterRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/register');
    final headers = {"Content-type": "application/json"};
    //use your own values
    final json = '{"name":"Faisal","email": "faisalrahman36@hotmail.com", "password": "test123","password2":"test123","walletAddress":"abcd4321","currency": "Rs","Longitude":-1,"Latitude":-1}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  Future<void> makePostLoginRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/login');
    final headers = {"Content-type": "application/json"};
    //use your own values
    final json = '{"email": "faisalrahman36@hotmail.com", "password": "test123"}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

Future<void> makePostTransactionRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    const uId="6230f4e56533456d85efa902"; //replace with uid from data
    final url = Uri.parse('$urlPrefix/transaction/'+uId);
    final headers = {"Content-type": "application/json"};
    //use your own vlaues
    final json = '{"email":"faisalrahman36@hotmail.com","amount":700,"currency":"Rs","walletAddress":"6230f4e56533456d85efa900","to":"622fd9d4a8f1f2eb0e48c1ff","transactionType":"testing","orderDescription":"testing app"}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  
Future<void> makePostScheduledTransactionRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    const uId="6230f4e56533456d85efa902"; //replace with uid from data
    final url = Uri.parse('$urlPrefix/scheduledTransaction/'+uId);
    final headers = {"Content-type": "application/json"};
    //use your own vlaues
    final json = '{"email":"faisalrahman36@hotmail.com","amount":700,"currency":"Rs","walletAddress":"6230f4e56533456d85efa900","to":"622fd9d4a8f1f2eb0e48c1ff","transactionType":"testing","orderDescription":"testing app","scheduledDateTime":"2022-05-12"}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }
  

  void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}