import 'package:ax_dapp/service/custom_styles.dart';
import 'package:ax_dapp/sports_markets/models/sports_markets_model.dart';
import 'package:ax_dapp/sports_markets/widgets/sports_view_button.dart';
import 'package:ax_dapp/sports_markets/widgets/widget_factories/sports_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopSportsCard extends StatelessWidget {
  const DesktopSportsCard({required this.sportsMarketsModel, super.key});

  final SportsMarketsModel sportsMarketsModel;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: 70,
      child: OutlinedButton(
        onPressed: () {
          context.goNamed(
            'sports-markets',
            pathParameters: {'name': sportsMarketsModel.name},
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SportsDetailsWidget(context, sportsMarketsModel)
                    .sportsDetailsCardsForWeb(
                  _width >= 875,
                  _width,
                ),
              ],
            ),
            Row(
              children: [
                if (_width >= 1090) ...[
                  const SizedBox(width: 25),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: boxDecoration(
                      Colors.transparent,
                      100,
                      2,
                      Colors.white,
                    ),
                    child: ViewButton(sports: sportsMarketsModel),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
