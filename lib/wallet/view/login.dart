import 'package:ax_dapp/util/util.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final bloc = context.read<WalletBloc>();
        final errorMessage = state.errorMessage;
        final walletViewStatus = state.walletViewStatus;
        if (state.hasFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showWarningToast(
              title: 'Error',
              description: errorMessage ?? 'Authentication Error',
            );
          });
          bloc.add(AuthFailed(walletViewStatus: walletViewStatus));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => context.read<WalletBloc>().add(
                      const LoginSignUpViewRequested(),
                    ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                textAlign: TextAlign.center,
                onChanged: (value) =>
                    context.read<WalletBloc>().add(EmailChanged(email: value)),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                textAlign: TextAlign.center,
                onChanged: (value) => context
                    .read<WalletBloc>()
                    .add(PassWordChanged(password: value)),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.',
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    primaryOrangeColor.withOpacity(0.15),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(width / 4, height * 0.09),
                  ),
                  maximumSize: MaterialStateProperty.all<Size>(
                    Size(width / 2, height * 0.10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () async {
                  context.read<WalletBloc>().add(
                        const ProfileViewRequestedFromLogin(),
                      );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Connect',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<WalletBloc>()
                              .add(const ConnectWalletRequested());
                        },
                    ),
                    TextSpan(
                      text: ' with Metamask or another external wallet',
                      style: TextStyle(
                        color: Colors.amber[400],
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Forgot Password?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context
                              .read<WalletBloc>()
                              .add(const ResetPasswordViewRequested());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
