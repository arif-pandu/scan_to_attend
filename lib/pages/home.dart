// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_to_attend/const/const.dart';
import 'package:scan_to_attend/controller/login_controller.dart';
import 'package:scan_to_attend/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  // it'll be like this (2021-11-23)
  String timestampNow = DateTime.now().year.toString() +
      '-' +
      DateTime.now().month.toString() +
      '-' +
      DateTime.now().day.toString();

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  LoginController loginController = Get.put(LoginController());

  bool isAlreadyPresence = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void callUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('USERNAME');
    LoginController loginController = Get.put(LoginController());
    loginController.usernameLogin = name!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callUsername();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    loginController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: _buildQrView(context),
            ),
          ),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: result == null
                  ?
                  // KALO BELUM DAPET HASI: BARCODE
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "POINT THE CAMERA AT",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            color: blackColor,
                          ),
                        ),
                        Container(
                          height: 87,
                          width: 87,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/will_you_read.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "QR CODE",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            color: blackColor,
                          ),
                        ),
                      ],
                    )
                  // KALO UDAH DAPET HASIL BARCODE
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            color: blackColor,
                          ),
                        ),
                        Container(
                          height: 56,
                          width: 208,
                          decoration: BoxDecoration(
                            color: yellowColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3, color: blackColor),
                          ),
                          child: Center(
                            child: Text(
                              loginController.usernameLogin,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Lato",
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Happy Your Day :)",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Lato",
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.

    double scanSize = MediaQuery.of(context).size.width * 0.7;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      // DI SINI GANTI KALO UDAH ABSEN NTAR GK BERFUNGSI LAGI
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanSize,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        onGetStoreBarcode();
      });
    });
  }

  void onGetStoreBarcode() async {
    FirebaseFirestore firestore = await FirebaseFirestore.instance;
    CollectionReference presence = firestore.collection('presence');
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('ISPRESENCE', true);
    loginController.isPresence = prefs.getBool('ISPRESENCE');
    DateTime now = DateTime.now();
    DateTime today =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    DateTime tomorrow =
        DateTime(now.year, now.month, now.day + 1, now.hour, now.minute);
    Future.delayed(
      Duration(
        minutes: today.difference(tomorrow).inMinutes.round(),
      ),
      () {
        prefs.setBool('ISPRESENCE', false);
      },
    );

    //
    presence
        .doc(timestampNow)
        .collection(loginController.usernameLogin)
        .doc(loginController.usernameLogin)
        .set({'presence': true});
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
