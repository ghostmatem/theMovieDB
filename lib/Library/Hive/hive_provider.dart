// import 'package:hive/hive.dart';

// class HiveProvider {

//   static final instance = HiveProvider._();

//   Map<String, int> _boxRegister = {};
//   Map<int, bool> _registredAdapters = {};

//   Future<Box<T>> openBox<T>(String name, TypeAdapter<T> adapter) {
//     registerAdapter<T>(adapter);

//     if (_boxRegister.containsKey(name)) {
//       _boxRegister[name] =  _boxRegister[name]! + 1;
//     } else {
//       _boxRegister[name] = 1;
//     }

//     return Hive.openBox<T>(name);
//   }

//   void registerAdapter<T>(TypeAdapter<T> adapter) {

//     if (_registredAdapters.containsKey(adapter.typeId)) return;

//     Hive.registerAdapter(adapter);
//     _registredAdapters[adapter.typeId] = true;
    
//   }

//   void closeBox(Box<dynamic> box) {
//     if (!_boxRegister.containsKey(box.name)) return;

//     _boxRegister[box.name] = _boxRegister[box.name]! - 1;

//     if (_boxRegister[box.name]! > 0) return;

//     _boxRegister.remove(box.name);
//     box.compact();
//     box.close();
//   }

//   HiveProvider._();
// }