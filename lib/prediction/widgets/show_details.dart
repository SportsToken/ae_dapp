import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails({
    super.key,
    required this.promptDetails,
  });

  final String promptDetails;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    final _height = MediaQuery.sizeOf(context).height;
    var wid = _width * 0.4;
    if (_width < 1160) wid = _width * 0.95;

    return SizedBox(
      width: wid,
      height: _height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  promptDetails,
                  textAlign: TextAlign.center,
                  style: textStyle(
                    Colors.white,
                    20,
                    isBold: false,
                    isUline: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
