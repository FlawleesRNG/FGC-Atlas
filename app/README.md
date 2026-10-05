# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Validação Start.gg

O runner técnico consulta um tournament real e converte a resposta para models
tipados, sem conectar a API à interface. No PowerShell, execute a partir da
pasta `app`:

```powershell
$env:START_GG_API_TOKEN="COLE_SEU_TOKEN_AQUI"
$env:START_GG_SLUG="tournament/genesis-x"
dart run "-DSTART_GG_API_TOKEN=$env:START_GG_API_TOKEN" "-DSTART_GG_SLUG=$env:START_GG_SLUG" tool/validate_startgg.dart
```

`START_GG_API_TOKEN` deve conter um token privado criado nas configurações de
desenvolvedor do start.gg. `START_GG_SLUG` deve conter o slug presente na URL do
tournament, como `tournament/genesis-x`.

Nunca salve ou faça commit do token no código, no README ou em qualquer arquivo
do repositório.

## Validação de entrants Start.gg

O runner de entrants consulta uma única página de participantes de um evento.
O slug precisa identificar um evento, no formato
`tournament/nome-do-tournament/event/nome-do-evento`.

No PowerShell, execute a partir da pasta `app`:

```powershell
$env:START_GG_API_TOKEN="COLE_SEU_TOKEN_AQUI"

dart run `
  "-DSTART_GG_API_TOKEN=$env:START_GG_API_TOKEN" `
  "-DSTART_GG_EVENT_SLUG=tournament/genesis-x/event/ultimate-singles" `
  "-DSTART_GG_PAGE=1" `
  "-DSTART_GG_PER_PAGE=64" `
  tool/validate_startgg_event_entrants.dart
```

Nunca faça commit do token nem o escreva diretamente no código. `START_GG_PAGE`
e `START_GG_PER_PAGE` são opcionais e usam, respectivamente, `1` e `64` como
valores padrão.
