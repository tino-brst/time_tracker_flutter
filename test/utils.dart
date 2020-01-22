/// Returns the type of [T]
///
/// Useful when having to pass a Type with generics as argument to a function
///
/// ```dart
///// Does not work
///find.byType(GenericWidget<int>)
///// Works
///find.byType(typeOf<GenericWidget<int>>())
/// ```

Type typeOf<T>() => T;
