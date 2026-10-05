import 'dart:io';

import 'package:app/src/services/startgg/graphql_client.dart';
import 'package:app/src/services/startgg/startgg_service.dart';

const _apiToken = String.fromEnvironment('START_GG_API_TOKEN');
const _tournamentSlug = String.fromEnvironment('START_GG_SLUG');

Future<void> main() async {
  stdout.writeln('Start.gg validation');

  if (_apiToken.trim().isEmpty) {
    _printConfigurationError('START_GG_API_TOKEN não informado.');
    return;
  }

  stdout.writeln('Token: OK');

  if (_tournamentSlug.trim().isEmpty) {
    _printConfigurationError('START_GG_SLUG não informado.');
    return;
  }

  final slug = _tournamentSlug.trim();
  stdout.writeln('Slug: $slug');

  final service = StartGGService.fromEnvironment();

  try {
    final tournament = await service.fetchTournamentBySlug(slug);

    stdout
      ..writeln()
      ..writeln('Tournament:')
      ..writeln('ID: ${tournament.id}')
      ..writeln('Nome: ${tournament.name}')
      ..writeln('Slug: ${tournament.slug}')
      ..writeln(
        'Data: ${tournament.startAt?.toIso8601String() ?? 'não informada'}',
      )
      ..writeln('Participantes: ${tournament.numAttendees ?? 'não informado'}')
      ..writeln('Eventos encontrados: ${tournament.events.length}')
      ..writeln()
      ..writeln('Eventos:');

    for (final event in tournament.events) {
      final entrants = event.numEntrants?.toString() ?? 'não informado';
      final game = _eventGameName(
        event.videogame?.displayName,
        event.videogame?.name,
      );

      stdout.writeln(
        '- [${event.id}] ${event.name} | Entrants: $entrants | Game: $game',
      );
    }

    stdout
      ..writeln()
      ..writeln('Status: sucesso');
  } catch (error) {
    _printRuntimeError(error);
  } finally {
    service.close();
  }
}

String _eventGameName(String? displayName, String? name) {
  if (displayName != null && displayName.isNotEmpty) {
    return displayName;
  }
  if (name != null && name.isNotEmpty) {
    return name;
  }
  return 'não informado';
}

void _printConfigurationError(String message) {
  stdout
    ..writeln()
    ..writeln('Resultado:')
    ..writeln('Status: erro')
    ..writeln('Tipo do erro: configuração')
    ..writeln('Mensagem: $message');
  exitCode = 64;
}

void _printRuntimeError(Object error) {
  final message = switch (error) {
    StartGGGraphQLException(:final errors) => '${error.message} $errors',
    StartGGException(:final message) => message,
    _ => error.toString(),
  };

  stdout
    ..writeln()
    ..writeln('Resultado:')
    ..writeln('Status: erro')
    ..writeln('Tipo do erro: ${error.runtimeType}')
    ..writeln('Mensagem: $message');
  exitCode = 1;
}
