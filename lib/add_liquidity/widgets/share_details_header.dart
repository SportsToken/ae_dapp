import 'package:ax_dapp/add_liquidity/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShareDetailsHeader extends StatelessWidget {
  const ShareDetailsHeader({super.key, required this.elementWdt, required this.isAdvDetails});

  final double elementWdt;
  final bool isAdvDetails;
  

  @override
  Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    return SizedBox(
      height: 30,
      width: elementWdt,
      child: Row(
        mainAxisAlignment:
            isWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Text(
            isAdvDetails ? 'Details: Price and Pool Share' : 'Details',
            style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(left: 6),
            child: const AddLiquidityToolTip(),
          )
        ],
      ),
    );
  }
}
