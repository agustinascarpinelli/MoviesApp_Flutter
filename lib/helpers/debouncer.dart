import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829
//el debouncer escucha las telas y dispara un valor cuando la persona deja de escribir
class Debouncer<T> {

  Debouncer({ 
    //cantidad de tiempo que quiero esperar antes de emitir un valor
    required this.duration, 
    //metodo que se dispara cuando ya tengo un valor
    this.onValue 
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}