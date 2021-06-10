import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class CartEvent {
  String? event;

  CartEvent(this.event);
}
