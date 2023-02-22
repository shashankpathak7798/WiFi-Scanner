import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WiFiAccessPoint> accessPoint = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool _isScanning = false;
  bool _isResultAvailable = false;

  void _startListeningToScannedResults() async {
    _isResultAvailable = true;
    final can = await WiFiScan.instance.canGetScannedResults(
      askPermissions: true,
    );
    switch (can) {
      case CanGetScannedResults.yes:
        subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((event) {
          setState(() {
            accessPoint = event;
          });
        });
    }
  }

  void _startScan() async {
    _isScanning = true;
    final canStart = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (canStart) {
      case CanStartScan.yes:
        final isScanning = await WiFiScan.instance
            .startScan()
            .then((value) => _startListeningToScannedResults());
    }
  }

  Widget buildList() {
    return _isResultAvailable
        ? ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.wifi),
              title: Text('${accessPoint[index].ssid}'),
              subtitle: Text('${accessPoint[index].bssid}'),
              trailing: Text('${accessPoint[index].level} dBm'),
              onTap: () => _showNetworkDetails(accessPoint[index]),
            ),
            itemCount: accessPoint.length,
          )
        : CircularProgressIndicator();
  }

  void _showNetworkDetails(WiFiAccessPoint network) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "Network Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.wifi),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${network.ssid}',
                            ),
                            Text('${network.bssid}'),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text('Strength: ${network.level} dBm'),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40,),
                  child: Row(
                    children: [
                      Text(
                        'Frequency: ${network.frequency}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WiFi Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.wifi_find_outlined),
            onPressed: _startScan,
          ),
        ],
      ),
      body: _isScanning
          ? Container(
              child: buildList(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Networks Available!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Click on the Icon on Top-Right to start the scan!',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
