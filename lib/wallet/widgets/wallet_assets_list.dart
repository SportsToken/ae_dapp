import 'package:ax_dapp/wallet/widgets/wallet_assets_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokens_repository/tokens_repository.dart';

class WalletAssetsList extends StatelessWidget {
  WalletAssetsList({super.key, required BoxConstraints boxConstraints})
      : constraints = boxConstraints;

  BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final currentTokens = context.read<TokensRepository>().currentTokens;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.5,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: currentTokens.length,
            itemBuilder: (context, index) {
              return WalletAssetCard(
                tokenAsset: currentTokens[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
