import 'package:ax_dapp/service/custom_styles.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:ax_dapp/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectedWalletPromoDialog extends StatelessWidget {
  const ConnectedWalletPromoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    var wid = 500.0;
    const edge = 20.0;
    if (_width < 505) wid = _width;
    var hgt = 345.0;
    if (_height < 350) hgt = _height;
    final walletAddress =
        context.read<WalletBloc>().state.formattedWalletAddress;
    final walletId = (walletAddress.isEmpty || walletAddress == kEmptyAddress)
        ? ''
        : walletAddress;

    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: (_width < 665)
            ? const EdgeInsets.symmetric(horizontal: 15)
            : EdgeInsets.zero,
        height: hgt,
        width: wid,
        decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
        child: Center(
          child: SizedBox(
            height: 325,
            width: wid - edge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                  width: wid - edge,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Wallet successfully connected!',
                  style: textStyle(
                    Colors.white,
                    20,
                    isBold: true,
                    isUline: false,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/x.jpg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Did you learn about AX from an existing AX User?',
                      style: textStyle(
                        Colors.white,
                        16,
                        isBold: false,
                        isUline: false,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      ' Use the following link to join our discord'
                      ' and shout them out and both of you will receive'
                      ' 1000 AX!',
                      style: textStyle(
                        Colors.white,
                        16,
                        isBold: false,
                        isUline: false,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 275,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<TrackingCubit>()
                              .onDiscordLinkClicked(walletId: walletId);
                          launchDiscordLink();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Claim Your AX!',
                          style: textStyle(
                            Colors.yellow,
                            19,
                            isBold: false,
                            isUline: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchDiscordLink() {
    const url = 'https://discord.gg/pAWyqJh67k';
    launchUrl(Uri.parse(url));
  }
}
