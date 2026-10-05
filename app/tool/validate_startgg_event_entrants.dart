import 'dart:io';

import 'package:app/src/services/startgg/graphql_client.dart';
import 'package:app/src/services/startgg/startgg_service.dart';

const _apiToken = String.fromEnvironment('START_GG_API_TOKEN');
const _eventSlug = String.fromEnvironment('START_GG_EVENT_SLUG');
const _pageValue = String.fromEnvironment('START_GG_PAGE', defaultValue: '1');
const _perPageValue = String.fromEnvironment(
  'START_GG_PER_PAGE',
  defaultValue: '64',
);

Future<void> main() async {
  stdout.writeln('Start.gg event entrants validation');

  if (_apiToken.trim().isEmpty) {
    _printConfigurationError('START_GG_API_TOKEN não informado.');
    return;
  }
  stdout.writeln('Token: OK');

  if (_eventSlug.trim().isEmpty) {
    _printConfigurationError('START_GG_EVENT_SLUG não informado.');
    return;
  }

  final page = int.tryParse(_pageValue);
  final perPage = int.tryParse(_perPageValue);
  if (page == null || page < 1) {
    _printConfigurationError('START_GG_PAGE deve ser um inteiro positivo.');
    return;
  }
  if (perPage == null || perPage < 1) {
    _printConfigurationError('START_GG_PER_PAGE deve ser um inteiro positivo.');
    return;
  }

  final eventSlug = _eventSlug.trim();
  stdout
    ..writeln('Event slug: $eventSlug')
    ..writeln('Page: $page')
    ..writeln('Per page: $perPage');

  final service = StartGGService.fromEnvironment();

  try {
    final entrants = await service.getEventEntrantsBySlug(
      eventSlug: eventSlug,
      page: page,
      perPage: perPage,
    );

    stdout
      ..writeln()
      ..writeln('Entrants encontrados: ${entrants.length}')
      ..writeln()
      ..writeln('Entrants:');

    for (final entrant in entrants) {
      stdout.writeln(
        '- ID: ${entrant.id} | Name: ${entrant.name} | Seed: ${entrant.seed ?? 'não informado'}',
      );
      stdout.writeln('  Participants:');

      if (entrant.participants.isEmpty) {
        stdout.writeln('  - nenhum participant informado');
        continue;
      }

      for (final participant in entrant.participants) {
        stdout.writeln(
          '  - GamerTag: ${participant.gamerTag} | '
          'Prefix: ${participant.prefix ?? 'não informado'} | '
          'Player ID: ${participant.player?.id ?? 'não informado'} | '
          'User ID: ${participant.player?.userId ?? 'não informado'}',
        );
      }
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

void _printConfigurationError(String message) {
  stdout
    ..writeln()
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
    ..writeln('Status: erro')
    ..writeln('Tipo do erro: ${error.runtimeType}')
    ..writeln('Mensagem: $message');
  exitCode = 1;
}
