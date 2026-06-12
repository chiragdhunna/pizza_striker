import 'pizza_event.dart';
import 'strike.dart';

/// Result of an admin adding a strike (`StrikeActionResult`). When the user
/// hits the threshold, [pizzaPartyTriggered] is true and [pizzaEvent] is set.
class StrikeActionResult {
  const StrikeActionResult({
    required this.strike,
    required this.pizzaEvent,
    required this.pizzaPartyTriggered,
    required this.message,
  });

  final Strike strike;
  final PizzaEvent? pizzaEvent;
  final bool pizzaPartyTriggered;
  final String message;

  factory StrikeActionResult.fromJson(Map<String, dynamic> json) {
    return StrikeActionResult(
      strike: Strike.fromJson(json['strike'] as Map<String, dynamic>),
      pizzaEvent: json['pizza_event'] != null
          ? PizzaEvent.fromJson(json['pizza_event'] as Map<String, dynamic>)
          : null,
      pizzaPartyTriggered: json['pizza_party_triggered'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
    );
  }
}
