import 'dart:developer' as developer;

import 'graphql_client.dart';
import 'models/startgg_entrant.dart';
import 'models/startgg_event.dart';
import 'models/startgg_tournament.dart';
import 'queries.dart';

class StartGGService {
  const StartGGService({required this.client});

  factory StartGGService.fromEnvironment({
    String apiToken = const String.fromEnvironment('START_GG_API_TOKEN'),
  }) {
    return StartGGService(client: StartGGGraphQLClient(apiToken: apiToken));
  }

  final StartGGGraphQLClient client;

  Future<List<StartGGEntrant>> getEventEntrantsBySlug({
    required String eventSlug,
    int page = 1,
    int perPage = 64,
  }) async {
    if (page < 1 || perPage < 1) {
      throw ArgumentError('page e perPage devem ser maiores que zero.');
    }

    final data = await client.query(
      StartGGQueries.eventEntrantsBySlug,
      operationName: 'EventEntrantsBySlug',
      variables: {'eventSlug': eventSlug, 'page': page, 'perPage': perPage},
    );

    final event = data['event'];
    if (event is! Map<String, dynamic>) {
      throw const StartGGGraphQLException([
        {'message': 'Evento não encontrado.'},
      ]);
    }

    final entrantsConnection = event['entrants'];
    if (entrantsConnection is! Map<String, dynamic>) {
      return const [];
    }

    final nodes = entrantsConnection['nodes'];
    if (nodes is! List) {
      return const [];
    }

    return nodes
        .whereType<Map<String, dynamic>>()
        .map(StartGGEntrant.fromJson)
        .toList(growable: false);
  }

  Future<StartGGTournament> fetchTournamentBySlug(String tournamentSlug) async {
    final data = await client.query(
      StartGGQueries.tournamentBySlug,
      operationName: 'TournamentBySlug',
      variables: {'slug': tournamentSlug},
    );

    final tournament = data['tournament'];
    if (tournament is! Map<String, dynamic>) {
      throw const StartGGGraphQLException([
        {'message': 'Tournament não encontrado.'},
      ]);
    }

    return StartGGTournament.fromJson(tournament);
  }

  Future<StartGGEvent> fetchEventBySlug(String eventSlug) async {
    final data = await client.query(
      StartGGQueries.eventBySlug,
      operationName: 'EventBySlug',
      variables: {'slug': eventSlug},
    );

    final event = data['event'];
    if (event is! Map<String, dynamic>) {
      throw const StartGGGraphQLException([
        {'message': 'Evento n\u00E3o encontrado.'},
      ]);
    }

    return StartGGEvent.fromJson(event);
  }

  Future<void> printEventSummary(String eventSlug) async {
    final event = await fetchEventBySlug(eventSlug);

    developer.log('Nome do evento: ${event.name}', name: 'StartGGService');
    developer.log('ID: ${event.id}', name: 'StartGGService');
    developer.log(
      'N\u00FAmero de participantes: ${event.numEntrants}',
      name: 'StartGGService',
    );
  }

  void close() => client.close();
}
