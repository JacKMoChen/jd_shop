import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class UserEvent {
  String? event;

  UserEvent(this.event);
}
