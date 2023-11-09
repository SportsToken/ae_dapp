import 'package:ax_dapp/account/bloc/account_bloc.dart';
import 'package:ax_dapp/account/models/models.dart';
import 'package:ax_dapp/account/widgets/widgets.dart';
import 'package:ax_dapp/service/custom_styles.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WalletAssetsList extends StatelessWidget {
  const WalletAssetsList({super.key, required BoxConstraints boxConstraints})
      : constraints = boxConstraints;

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final currentTokens =
        context.select((WalletBloc bloc) => bloc.state.tokens);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.5,
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (BuildContext context, state) {
              if (state.selectedAssets == AccountAssets.all) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentTokens.length,
                  itemBuilder: (context, index) {
                    return AccountAssetCard(
                      token: currentTokens[index],
                    );
                  },
                );
              }
              if (state.selectedAssets == AccountAssets.Crypto) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentTokens.length,
                  itemBuilder: (context, index) {
                    return AccountAssetCard(
                      token: currentTokens[index],
                    );
                  },
                );
              }
              if (state.selectedAssets == AccountAssets.APTs) {
                return Center(
                  child: Text(
                    'Coming Soon!',
                    style: textStyle(
                      Colors.white,
                      20,
                      isBold: false,
                      isUline: false,
                    ),
                  ),
                );
              }
              if (state.selectedAssets == AccountAssets.NFTs) {
                Center(
                  child: Text(
                    'Coming Soon!',
                    style: textStyle(
                      Colors.white,
                      20,
                      isBold: false,
                      isUline: false,
                    ),
                  ),
                );
              }
              return Center(
                child: Text(
                  'Select an asset',
                  style: textStyle(
                    Colors.white,
                    20,
                    isBold: false,
                    isUline: false,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
