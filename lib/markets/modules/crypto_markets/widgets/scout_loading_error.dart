import 'package:flutter/material.dart';

class ScoutLoadingError extends StatelessWidget {
  const ScoutLoadingError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 70,
        width: 400,
        child: Text(
          'Failed to load active Markets',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
