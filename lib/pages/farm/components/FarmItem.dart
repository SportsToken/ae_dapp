import 'package:flutter/material.dart';

import 'package:ax_dapp/service/Controller/Farms/FarmController.dart';
import 'package:ax_dapp/pages/farm/components/SingleLogoFarmTitle.dart';
import 'package:ax_dapp/pages/farm/components/DoubleLogoFarmTitle.dart';
import 'package:ax_dapp/pages/farm/modules/PageTextStyle.dart';
import 'package:ax_dapp/pages/farm/modules/BoxDecoration.dart';
import 'package:get/get.dart';

Widget farmItem(BuildContext context, bool isWeb, FarmController farm,
    double listHeight, double layoutWdt) {
  double minCardHeight = 200;
  double maxCardHeight = 350;
  double cardWidth = isWeb ? 500 : layoutWdt;
  double cardHeight = listHeight * 0.4;
  if (cardHeight < minCardHeight) cardHeight = minCardHeight;
  if (cardHeight > maxCardHeight) cardHeight = maxCardHeight;

  TextStyle txStyle = textStyle(Colors.grey[600]!, 14, false, false);
  Widget farmTitleWidget;
  //TODO: dualStakeDialog does not currently work, uncomment if else statement once it is fixed
  // if (farm.athlete == null) {
  farmTitleWidget = singleLogoFarmTitle(context, isWeb, farm, cardWidth);
  // } else {
  //   farmTitleWidget = doubleLogoFarmTitle(context, isWeb, farm, cardWidth);
  // }

  return Container(
    height: cardHeight,
    width: cardWidth,
    margin: isWeb
        ? EdgeInsets.symmetric(horizontal: 5, vertical: 5)
        : EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 20),
    decoration: boxDecoration(
        Color(0x80424242).withOpacity(0.25), 20, 1, Colors.grey[600]!),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        farmTitleWidget,
        // Current Balance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Current Balance",
              style: txStyle,
            ),
            Obx(() => Text(
                "${farm.stakingInfo.value.viewAmount} ${farm.strStakedSymbol}",
                style: txStyle))
          ],
        ),
        // TVL
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "TVL",
              style: txStyle,
            ),
            Text("\$${farm.strTVL}", style: txStyle)
          ],
        ),
        // Total APY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Total APR", style: txStyle),
            Text("${farm.strAPR}%", style: txStyle)
          ],
        ),
      ],
    ),
  );
}
