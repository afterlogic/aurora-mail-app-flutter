// helper wrapper for copyWith methods in case value needs to become null
class CWVal<T> {
  final T val;

  static T get<T>(CWVal<T> item, T fallbackItem) {
    return item != null ? item.val : fallbackItem;
  }

  const CWVal(this.val);
}
