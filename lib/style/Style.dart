import 'dart:math';

// flutter format .

import 'package:ae_dapp/service/colors.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
// import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ae_dapp/pages/AXPage.dart';

const double lgTxSize = 52;
const double mdTxSize = 35;
const double smTxSize = 15;
const double xsTxSize = 12;

const url = "https://www.axmarkets.net/ax";

final ButtonStyle walletButton = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: smTxSize,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w600),
    primary: Colors.grey[800],
    onPrimary: Colors.amber[600],
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0)),
    fixedSize: Size(350, 60));

final ButtonStyle approveButton = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: smTxSize,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w600),
    primary: Colors.grey[800],
    onPrimary: Colors.amber[600],
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0)),
    fixedSize: Size(250, 75));

final ButtonStyle claimButton = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: smTxSize,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w600),
    primary: Colors.grey[800],
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0)),
    onPrimary: Colors.amber[600],
    fixedSize: Size(250, 75));

final ButtonStyle connectButton = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: smTxSize,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w200),
    primary: Colors.blue.withOpacity(0.3),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0)),
    onPrimary: Colors.white.withOpacity(0.8),
    fixedSize: Size(250, 75));

final ButtonStyle confirmSwap = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: smTxSize,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w400),
    primary: Colors.amber[600],
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0)),
    onPrimary: Colors.white,
    fixedSize: Size(350, 50));

final ButtonStyle longButton = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: smTxSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
  primary: Colors.green,
  onPrimary: Colors.white,
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
  side: BorderSide(color: (Colors.grey[900])!),
);

final ButtonStyle shortButton = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: smTxSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
  primary: Colors.red,
  onPrimary: Colors.white,
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
  side: BorderSide(color: (Colors.grey[900])!),
);

final ButtonStyle mintButton = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: smTxSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
  primary: Colors.grey[900],
  onPrimary: Colors.white,
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
  side: BorderSide(color: (Colors.amber[600])!, width: 2),
);

final ButtonStyle redeemButton = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: smTxSize, fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
  primary: Colors.grey[900],
  onPrimary: Colors.white,
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
  side: BorderSide(color: (Colors.amber[600])!, width: 2),
);

final ButtonStyle inactiveSport = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: 10, fontFamily: 'OpenSans', fontWeight: FontWeight.w400),
  primary: Colors.grey[900],
  onPrimary: Colors.grey[800],
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
);

final ButtonStyle nflButton = ElevatedButton.styleFrom(
  textStyle: TextStyle(
      fontSize: 10, fontFamily: 'OpenSans', fontWeight: FontWeight.w400),
  primary: Colors.amber[600],
  onPrimary: Colors.grey[800],
  shape:
      new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
  side: BorderSide(color: (Colors.amber[600])!, width: 2),
);

final TextStyle confirmText = TextStyle(
    color: Colors.grey[500], fontWeight: FontWeight.w100, fontSize: 15);

final TextStyle confirmTextPercent =
    TextStyle(color: Colors.red, fontWeight: FontWeight.w100, fontSize: 12);

final TextStyle confirmTextCoin = TextStyle(
    color: Colors.grey[200], fontWeight: FontWeight.w600, fontSize: 23);

final TextStyle confirmTextOther = TextStyle(
    color: Colors.grey[500], fontWeight: FontWeight.w100, fontSize: 13);

final TextStyle confirmTextOtherBold = TextStyle(
    color: Colors.grey[400], fontWeight: FontWeight.w600, fontSize: 13);

final TextStyle mintAndRedeemText = TextStyle(
    color: Colors.amber.withOpacity(0.4),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 13);

final TextStyle athleteListText = TextStyle(
    letterSpacing: 1,
    color: Colors.amber.withOpacity(0.6),
    fontSize: 20,
    fontWeight: FontWeight.w200);

final TextStyle athleteText = TextStyle(
    letterSpacing: 1,
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.w200);

final TextStyle athleteWAR = TextStyle(
    letterSpacing: 1,
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.w200);

final TextStyle athletePercent = TextStyle(
    letterSpacing: 1,
    color: Colors.green,
    fontSize: 20,
    fontWeight: FontWeight.w200);

final TextStyle athleteCardName = TextStyle(
    letterSpacing: 1,
    color: Colors.white.withOpacity(0.8),
    fontSize: 18,
    fontWeight: FontWeight.w200);

final TextStyle athleteCardPrice = TextStyle(
    letterSpacing: 1,
    color: Colors.white.withOpacity(0.8),
    fontSize: 15,
    fontWeight: FontWeight.w200);
