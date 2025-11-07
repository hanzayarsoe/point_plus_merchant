mixin DisplayNameEnum on Enum {
  String get displayName;
}

enum Gender with DisplayNameEnum {
  male('Male'),
  female('Female'),
  other('Other');

  @override
  final String displayName;
  const Gender(this.displayName);
}

enum ApiMethod { get, put, post, patch }

enum DialogType { confirm, delete }

enum TransactionType { transfer, receive, withdraw, recharge }
