import 'package:ax_dapp/pages/league/models/league.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LeagueRepository {
  LeagueRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  Future<void> createLeague({
    required LeagueData leagueData,
  }) async {
    try {
      await _fireStore.collection('Leagues').add(leagueData.toJson());
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }

  Future<List<LeagueData>> fetchLeagues() async {
    try {
      final leagues = await _fireStore.collection('Leagues').get();
      return leagues.docs.map((e) => LeagueData.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<void> deleteLeague({required String leagueId}) async {
    try {
      await _fireStore
          .collection('Leagues')
          .doc(leagueId)
          .collection('Rosters')
          .get()
          .then((snapshot) async {
        for (final doc in snapshot.docs) {
          await _fireStore
              .collection('Leagues')
              .doc(leagueId)
              .collection('Rosters')
              .doc(doc.id)
              .delete();
        }
      });

      await _fireStore.collection('Leagues').doc(leagueId).delete();
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> updateLeague({
    required String leagueId,
    required LeagueData leagueData,
  }) async {
    try {
      await _fireStore
          .collection('Leagues')
          .doc(leagueId)
          .update(leagueData.toJson());
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> updateRoster({
    required String leagueId,
    required String userWallet,
    required List<String> roster,
  }) async {
    try {
      await _fireStore
          .collection('Leagues')
          .doc(leagueId)
          .collection('Rosters')
          .doc(userWallet)
          .update({'APT_list': roster});
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> enrollUser({
    required String leagueId,
    required String userWallet,
    required List<String> roster,
  }) async {
    try {
      await _fireStore
          .collection('Leagues')
          .doc(leagueId)
          .collection('Rosters')
          .doc(userWallet)
          .set({'APT_list': roster});
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> removeUser({
    required String leagueId,
    required String userWallet,
  }) async {
    try {
      await _fireStore
          .collection('Leagues')
          .doc(leagueId)
          .collection('Rosters')
          .doc(userWallet)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint('$e');
    }
  }
}
