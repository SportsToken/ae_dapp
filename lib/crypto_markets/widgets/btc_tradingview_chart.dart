import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

/// This class has one job: Produce a tradingview chart of the BTC/USD price action
/// It accomplishes this through rendering a website  author: @user2745
class BtcTradingViewChart extends StatefulWidget {
  const BtcTradingViewChart({super.key});

  @override
  State<BtcTradingViewChart> createState() => _BtcTradingViewChartState();
}

class _BtcTradingViewChartState extends State<BtcTradingViewChart> {
  late Widget BtcChart;
  final _iframeElement = IFrameElement();

  @override
  void initState() {
    super.initState();
    _iframeElement
      ..height = '400'
      ..width = '400'
      ..src = 'https://ax-dapp-btc-chart.on-fleek.app/';
    _iframeElement.style.borderRadius = '14px';
    _iframeElement.style.borderColor = 'rgba(254, 197, 0, 1)';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    BtcChart = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: BtcChart,
        );
      },
    );
  }
}
