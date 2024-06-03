import 'package:ax_dapp/predict/models/prediction_model.dart';
import 'package:ax_dapp/predict/widgets/widget_factories/widget_factories.dart';
import 'package:ax_dapp/service/custom_styles.dart';
import 'package:flutter/material.dart';

class CollegePredictionsDetailsWidget implements PredictionDetailsWidget {
  const CollegePredictionsDetailsWidget(this.predictionModel);

  final PredictionModel predictionModel;

  @override
  Widget predictionDetailsCardsForMobile(
    double prdNameBx, {
    required bool showIcon,
  }) {
    // TODO: implement predictionDetailsCardsForMobile
    throw UnimplementedError();
  }

  @override
  Widget predictionDetailsCardsForWeb(double _width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Icon(
            Icons.school,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(
          width: _width * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                predictionModel.prompt,
                style: textStyle(
                  Colors.white,
                  18,
                  isBold: false,
                  isUline: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget predictionPageDetails() {
    return Center(
      child: Text(predictionModel.details),
    );
  }

  @override
  Widget predictionPageKeyStatistics() {
    // TODO: implement predictionPageKeyStatistics
    throw UnimplementedError();
  }

  @override
  Widget predictionPageKeyStatisticsForMobile() {
    return const Row(
      
    );
  }
}
