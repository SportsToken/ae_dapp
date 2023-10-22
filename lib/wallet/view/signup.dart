import 'package:ax_dapp/util/colors.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatelessWidget {
  SignUpView({
    super.key,
  });

  final kTextFieldDecoration = InputDecoration(
    hintText: '',
    hintStyle: const TextStyle(color: Colors.white),
    fillColor: secondaryOrangeColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryOrangeColor),
      borderRadius: const BorderRadius.all(Radius.circular(32)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryOrangeColor, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(32)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final _auth = FirebaseAuth.instance;
    String email;
    String password;
    var showSpinner = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Password',
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
              onPressed: () async {
                context.read<WalletBloc>().add(const ProfileViewRequested());
                try {
                  // TODO: Migrate to BLoC
                  // final newUser = await _auth.createUserWithEmailAndPassword(
                  //   email: email,
                  //   password: password,
                  // );
                } catch (e) {}
              },
              child: FittedBox(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.amber[400],
                    fontSize: 40,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
