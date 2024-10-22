import 'package:radio_horizon/src/requires_initialization.dart';

class BotStartDuration implements RequiresInitialization {
  late final DateTime startDate;

  @override
  Future<void> init() async {
    startDate = DateTime.now();
  }
}
