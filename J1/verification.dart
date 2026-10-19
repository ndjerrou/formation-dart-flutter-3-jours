import '02_classes_todo/verification.dart' as todo;
import '03_deck/verification.dart' as deck;
import '04_cli/corrections/verification.dart' as cli;

Future<void> main() async {
  todo.main();
  deck.main();
  await cli.main();
  print('J1 : toutes les vérifications sont réussies.');
}
