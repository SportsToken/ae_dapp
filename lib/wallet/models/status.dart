// Models all the possible states of the wallet

import 'package:ax_dapp/wallet/widgets/widgets.dart';

enum WalletViewStatus { initial, loading, login, signup, profile, error, none }

/// [WalletViewStatus] extensions.
extension WalletViewStatusX on WalletViewStatus {
  /// Returns `true` when this status is connected.
  bool get isConnected => this == WalletViewStatus.profile;

  WalletViewStatus currentStatus() {
    switch (this) {
      case WalletViewStatus.initial:
        return WalletViewStatus.initial;
      case WalletViewStatus.loading:
        return WalletViewStatus.loading;
      case WalletViewStatus.login:
        return WalletViewStatus.login;
      case WalletViewStatus.profile:
        return WalletViewStatus.profile;
      case WalletViewStatus.signup:
        return WalletViewStatus.signup;
      case WalletViewStatus.error:
        return WalletViewStatus.error;
      case WalletViewStatus.none:
        return WalletViewStatus.none;
    }
  }

  /// Returns `true` when this status is unsupported.
  bool get isUnsupported => this == WalletViewStatus.error;
}
