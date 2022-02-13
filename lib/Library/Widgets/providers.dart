import 'package:flutter/material.dart';

class NotifierProvider<Model extends Listenable> extends InheritedNotifier {
  const NotifierProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(notifier: model, child: child, key: key);

  final Model model;

  static NotifierProvider<Model>? watch<Model extends Listenable> (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>();
  }

  static NotifierProvider<Model>? read<Model extends Listenable> (BuildContext context) {  
    return (context
    .getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()
    as NotifierProvider<Model>);
  }
}

class Provider<Model> extends InheritedWidget {
  const Provider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(child: child, key: key);

  final Model model;

  static Provider<Model>? watch<Model> (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>();
  }

  static Provider<Model>? read<Model> (BuildContext context) {  
    return (context
    .getElementForInheritedWidgetOfExactType<Provider<Model>>()
    as Provider<Model>);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as Provider<Model>).model != model;
  }
}