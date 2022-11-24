/// Tries to find an object in the index specified, and returns it if found.
/// If the object is not found, returns [Null].
extension MaybeAt<T> on List<T> {
  /// Tries to find an object in the index specified, and returns it if found.
  /// If the object is not found, returns [Null].
  T? maybeAt(int index) {
    if (length <= index) return null;
    try {
      if (T is String) {
        return ((this[index] as String?)?.isNotEmpty ?? false)
            ? this[index]
            : null;
      }
      return this[index];
    } catch (_) {}
    return null;
  }
}
