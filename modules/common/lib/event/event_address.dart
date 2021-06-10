import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class AddressEvent {
  String? event;

  AddressEvent(this.event);
}
