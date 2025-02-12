import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

extension ToastX on BuildContext {
  void showWalletWarningToast() => MotionToast(
        icon: Icons.warning,
        primaryColor: Colors.black.withOpacity(0.3),
        secondaryColor: Colors.amber[400],
        title: Text(
          'Wallet Warning',
          style: TextStyle(
            color: Colors.amber[400],
            fontSize: 18,
            fontFamily: 'OpenSans',
          ),
        ),
        description: Text(
          'You need to connect Wallet to use this feature.',
          style: TextStyle(
            color: Colors.amber[400],
            fontFamily: 'OpenSans',
          ),
        ),
      ).show(this);

  void showWarningToast({
    required String title,
    required String description,
  }) =>
      MotionToast(
        icon: Icons.warning,
        primaryColor: Colors.black.withOpacity(0.3),
        secondaryColor: Colors.amber[400],
        title: Text(
          title,
          style: TextStyle(
            color: Colors.amber[400],
            fontSize: 18,
            fontFamily: 'OpenSans',
          ),
        ),
        description: Text(
          description,
          style: TextStyle(
            color: Colors.amber[400],
            fontFamily: 'OpenSans',
          ),
        ),
      ).show(this);
}
