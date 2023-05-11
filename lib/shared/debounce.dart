import 'dart:async';

class Debounce {
  Timer? _timer;

  void handle(Function function) {
    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 200), () {
      function.call();
    });
  }
}
