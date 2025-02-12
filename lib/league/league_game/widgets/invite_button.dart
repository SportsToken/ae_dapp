import 'package:ax_dapp/app/config/app_config.dart';
import 'package:ax_dapp/league/league_game/bloc/league_game_bloc.dart';
import 'package:ax_dapp/util/snackbar_warning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:league_repository/league_repository.dart';

class Invite extends StatelessWidget {
  const Invite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerStatus =
        context.select((LeagueGameBloc bloc) => bloc.state.timerStatus);
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: Colors.amber[400]!),
          ),
        ),
      ),
      onPressed: timerStatus.hasEnded
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                context.showSnackBarWarning(
                  warningMessage:
                      'The League Has Ended And Invite Links Are No Longer Available!',
                ),
              );
            }
          : () {
              final gamePageLocation =
                  GoRouterState.of(context).uri.toString().substring(1);
              final gamePageUrl = '$baseUrl$gamePageLocation';
              Clipboard.setData(
                ClipboardData(
                  text: gamePageUrl,
                ),
              ).then(
                (_) => ScaffoldMessenger.of(context).showSnackBar(
                  context.showSnackBarWarning(
                    warningMessage: 'Copied Invite Link!',
                  ),
                ),
              );
            },
      child: const Text(
        'Invite',
        style: TextStyle(
          color: Colors.amber,
          fontFamily: 'OpenSans',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
