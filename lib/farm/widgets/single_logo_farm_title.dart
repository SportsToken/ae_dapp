import 'package:ax_dapp/farm/dialogs/dialogs.dart';
import 'package:ax_dapp/farm/dialogs/stake/bloc/stake_bloc.dart';
import 'package:ax_dapp/farm/widgets/widgets.dart';
import 'package:ax_dapp/service/controller/farms/farm_controller.dart';
import 'package:ax_dapp/service/custom_styles.dart';
import 'package:ax_dapp/util/toast_extensions.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleLogoFarmTitle extends StatelessWidget {
  const SingleLogoFarmTitle({
    super.key,
    required this.farm,
    required this.cardWidth,
  });

  final FarmController farm;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200 || constraints.maxWidth < 600) {
          return SizedBox(
            width: cardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/x.jpg'),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
                Expanded(
                  child: farm.athlete == null
                      ? SportToken(
                          sport: farm.sport,
                          symbol: '${farm.strName} Farm',
                        )
                      : SportToken(
                          sport: farm.sport,
                          symbol: '${farm.athlete!} Farm',
                        ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 110,
                  height: 35,
                  decoration: boxDecoration(
                    Colors.amber[600]!,
                    100,
                    0,
                    Colors.amber[600]!,
                  ),
                  child: TextButton(
                    onPressed: () {
                      final isWalletConnected =
                          context.read<WalletBloc>().state.isWalletConnected;
                      if (isWalletConnected) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext builderContext) =>
                              BlocProvider(
                            create: (context) => StakeBloc(
                              farmController: farm,
                            ),
                            child: StakeDialog(
                              farm: farm,
                              layoutWdt: cardWidth,
                            ),
                          ),
                        );
                      } else {
                        context.showWalletWarningToast();
                      }
                    },
                    child: Text(
                      'Stake',
                      style: textStyle(
                        Colors.black,
                        14,
                        isBold: true,
                        isUline: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            width: cardWidth,
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/x.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: farm.athlete == null
                      ? SportToken(
                          sport: farm.sport,
                          symbol: '${farm.strName} Farm',
                        )
                      : SportToken(
                          sport: farm.sport,
                          symbol: '${farm.athlete!} Farm',
                        ),
                ),
                const Spacer(),
                Container(
                  width: 110,
                  height: 35,
                  decoration: boxDecoration(
                    Colors.amber[600]!,
                    100,
                    0,
                    Colors.amber[600]!,
                  ),
                  child: TextButton(
                    onPressed: () {
                      final isWalletConnected =
                          context.read<WalletBloc>().state.isWalletConnected;
                      if (isWalletConnected) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext builderContext) => StakeDialog(
                            farm: farm,
                            layoutWdt: cardWidth,
                          ),
                        );
                      } else {
                        context.showWalletWarningToast();
                      }
                    },
                    child: Text(
                      'Stake',
                      style: textStyle(
                        Colors.black,
                        14,
                        isBold: true,
                        isUline: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
