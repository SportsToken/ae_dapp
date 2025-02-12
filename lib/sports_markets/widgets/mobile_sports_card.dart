import 'package:ax_dapp/sports_markets/models/sports_markets_model.dart';
import 'package:ax_dapp/sports_markets/widgets/widget_factories/sports_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileSportsCard extends StatelessWidget {
  const MobileSportsCard({
    super.key,
    required this.sportsMarketsModel,
  });

  final SportsMarketsModel sportsMarketsModel;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          height: 70,
          child: OutlinedButton(
            onPressed: () {
              context.goNamed(
                'sports-markets',
                pathParameters: {
                  'name': sportsMarketsModel.name,
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: SportsDetailsWidget(context, sportsMarketsModel)
                      .sportsDetailsCardsForMobile(_width > 290, _width * 0.60),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
