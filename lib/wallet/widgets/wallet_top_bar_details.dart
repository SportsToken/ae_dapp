import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTopBarDetails extends StatelessWidget {
  const WalletTopBarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    var showAccountIcon = true;
    if (_width < 650) showAccountIcon = false;
    return TextButton(
      onPressed: () => Scaffold.of(context).openEndDrawer(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (showAccountIcon)
            const Icon(
              Icons.account_balance_wallet,
              color: Colors.grey,
            ),
          BlocSelector<WalletBloc, WalletState, String>(
            selector: (state) => state.walletAddress,
            builder: (_, walletAddress) {
              var formattedWalletAddress = '';
              if (walletAddress.isNotEmpty) {
                final walletAddressPrefix = walletAddress.substring(0, 7);
                final walletAddressSuffix = walletAddress.substring(
                  walletAddress.length - 5,
                  walletAddress.length,
                );
                formattedWalletAddress =
                    '$walletAddressPrefix...$walletAddressSuffix';
              }
              return Text(
                formattedWalletAddress,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'OpenSans',
                  fontSize: 11,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
