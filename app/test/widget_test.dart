import 'package:flutter_test/flutter_test.dart';

import 'package:app/app.dart';

void main() {
  testWidgets('opens the FGC Atlas home screen', (tester) async {
    await tester.pumpWidget(const AtlasApp());
    await tester.pumpAndSettle();

    expect(find.text('FGC Atlas'), findsOneWidget);
    expect(find.text('Ranking competitivo da FGC'), findsOneWidget);
    expect(find.text('Flawlees'), findsOneWidget);
    expect(find.text('Santa Catarina, BR'), findsOneWidget);
    expect(find.text('start.gg/@flawlees'), findsOneWidget);
    expect(find.text('Rank BR'), findsOneWidget);
    expect(find.text('#17'), findsOneWidget);
    expect(find.text('Personagens'), findsOneWidget);
    expect(find.text('Próxima Atualização'), findsOneWidget);
    expect(find.text('Estatísticas Gerais'), findsOneWidget);
    expect(find.text('Eventos Recentes'), findsOneWidget);
  });
}
