// ignore_for_file: public_member_api_docs, sort_constructors_first
class ValidationItem {
  dynamic value;
  String? error;
  ValidationItem(
    this.value,
    this.error,
  );

  @override
  String toString() => 'ValidationItem(value: $value, error: $error)';
}
