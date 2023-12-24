import 'package:flame/components.dart';

class ComponentPool<T extends PositionComponent> {
  List<T> _comps = [];
  int _length = 0;

  ComponentPool();

  ComponentPool.builder(
    int length,
    Vector2 offset,
    T Function() createComponent,
  ) {
    _comps = List.generate(length, (index) {
      T component = createComponent();
      component.position.x += index * offset.x;
      return component;
    });

    _length = length;
  }

  get components => _comps;

  get length => _length;
}
