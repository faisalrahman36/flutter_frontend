import 'package:flutter/material.dart';
import 'package:demo_flutter_get_post/walletDat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final stateManager = HomePageManager();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Center(
          child: Wrap(
            spacing: 50,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: stateManager.makeGetUserRequest,
                child: Text('GET User Info'),
              ),
              ElevatedButton(
                onPressed: stateManager.makeGetTransactionsRequest,
                child: Text('GET User Transaciton History'),
              ),
              ElevatedButton(
                onPressed: stateManager.makeGetScheduledTransactionsRequest,
                child: Text('GET User Scheduled Transaction History'),
              ),
              

              ElevatedButton(
                onPressed: stateManager.makePostRegisterRequest,
                child: Text('POST Register Request'),
              ),
              ElevatedButton(
                onPressed: stateManager.makePostLoginRequest,
                child: Text('POST Login Request'),
              ),

              ElevatedButton(
                onPressed: stateManager.makePostTransactionRequest,
                child: Text('POST Transaction Request'),
              ),


              ElevatedButton(
                onPressed: stateManager.makePostScheduledTransactionRequest,
                child: Text('POST Scheduled Transaction Request'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ValueListenableBuilder<RequestState>(
          valueListenable: stateManager.resultNotifier,
          builder: (context, requestState, child) {
            if (requestState is RequestLoadInProgress) {
              return CircularProgressIndicator();
            } else if (requestState is RequestLoadSuccess) {
              return Expanded(child: SingleChildScrollView(child: Text(requestState.body)));
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}