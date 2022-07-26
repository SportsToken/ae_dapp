import 'package:shared/shared.dart';

/// {@template wallet_credentials}
/// Holds [Credentials] for the connected wallet.
/// {@endtemplate}
class WalletCredentials extends Equatable {
  /// {@macro wallet_credentials}
  const WalletCredentials(CredentialsWithKnownAddress credentials)
      : _credentials = credentials;

  /// {@template _credentials}
  /// [Credentials] obtained from `MetaMask` through `requestAccount()`.
  /// {@endtemplate}
  final CredentialsWithKnownAddress _credentials;

  /// {@macro _credentials}
  CredentialsWithKnownAddress get value => _credentials;

  @override
  List<Object?> get props => [_credentials.address];
}
