import 'package:ax_dapp/service/custom_styles.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:tokens_repository/tokens_repository.dart';

class BadgeToken extends StatelessWidget {
  const BadgeToken({
    super.key,
    required this.sport,
    required this.symbol,
  });

  final SupportedSport sport;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeStyle: BadgeStyle(
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(8),
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
      ),
      badgeContent: Text(
        sport.name.toUpperCase(),
        style: textStyle(
          Colors.white,
          12,
          isBold: true,
          isUline: false,
        ),
      ),
      position: BadgePosition.topEnd(top: -10, end: -12),
      child: Text(
        symbol,
        style: textStyle(
          Colors.white,
          24,
          isBold: true,
          isUline: false,
        ),
      ),
    );
  }
}

class SimpleToken extends StatelessWidget {
  const SimpleToken({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        symbol,
        style: textStyle(
          Colors.white,
          24,
          isBold: true,
          isUline: false,
        ),
      ),
    );
  }
}

class SportToken extends StatelessWidget {
  const SportToken({
    super.key,
    required this.sport,
    required this.symbol,
  });

  final SupportedSport sport;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    if (sport == SupportedSport.all) return SimpleToken(symbol: symbol);
    return BadgeToken(sport: sport, symbol: symbol);
  }
}
