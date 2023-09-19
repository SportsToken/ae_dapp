import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:ax_dapp/util/helper.dart';
import 'package:ax_dapp/util/util.dart';
import 'package:ax_dapp/wallet/wallet.dart';
import 'package:ax_dapp/wallet/widgets/login.dart';
import 'package:ax_dapp/wallet/widgets/sign_up_button.dart';
import 'package:ax_dapp/wallet/widgets/wallet_chain.dart';
import 'package:ax_dapp/wallet/widgets/wallet_gas.dart';
import 'package:ax_dapp/wallet/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const textSize = 20.0;
    return Drawer(
      width: width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocConsumer<WalletBloc, WalletState>(
            listenWhen: (previous, current) =>
                previous.walletStatus != current.walletStatus ||
                previous.failure != current.failure,
            listener: (context, state) {
              if (state.isWalletUnsupported) {}

              if (state.isWalletUnavailable) {
                context.showWarningToast(
                    title: 'Wallet Unavailable',
                    description: 'This wallet type is currently unavailable.');
              }
            },
            buildWhen: (previous, current) =>
                previous.walletStatus != current.walletStatus,
            builder: (context, state) {
              if (state.isWalletConnected) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AccountDialog(),
                  ],
                );
              } else {
                return const Column(children: [SignUpButton(), Login()]);
              }
            },
          ),
        ],
      ),
    );
  }
}
