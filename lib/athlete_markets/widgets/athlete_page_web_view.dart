import 'package:ax_dapp/athlete_markets/widgets/widgets.dart';
import 'package:ax_dapp/markets/markets.dart';
import 'package:ax_dapp/util/chart/extensions/graph_data.dart';
import 'package:flutter/material.dart';

class AthletePageWebView extends StatelessWidget {
  const AthletePageWebView({
    super.key,
    required this.athlete,
    required this.chartStats,
  });

  final AthleteScoutModel athlete;
  final List<GraphData> chartStats;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    final _height = MediaQuery.sizeOf(context).height;
    double _containerWdt, _containerHgt;
    // normal mode (dual)
    if (_width > 1160 && _height > 660) {
      _containerHgt = _height;
      _containerWdt = _width;
      return SizedBox(
        height: _containerHgt,
        width: _containerWdt,
        child: Center(
          child: SizedBox(
            width: _width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GraphSide(
                  athlete: athlete,
                  chartStats: chartStats,
                  containerHeight: _containerHgt,
                  containerWidth: _containerWdt,
                ),
                StatsSide(
                  athlete: athlete,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // stacked scroll (portrait mode)
    _containerHgt = (_height * 0.90) - AppBar().preferredSize.height;
    _containerWdt = _width * 0.95;
    return Container(
      margin: EdgeInsets.only(top: AppBar().preferredSize.height + 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          SizedBox(
            height: _containerHgt,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  SizedBox(
                    width: _containerWdt,
                    child: GraphSide(
                      athlete: athlete,
                      chartStats: chartStats,
                      containerHeight: _containerHgt,
                      containerWidth: _containerWdt,
                    ),
                  ),
                  SizedBox(
                    width: _containerWdt,
                    child: StatsSide(
                      athlete: athlete,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
