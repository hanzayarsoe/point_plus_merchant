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

enum ActiveDateField { start, end }

enum DialogType { confirm, delete }

enum HistoryTransactionType with DisplayNameEnum {
  all('All'),
  inflow('Inflow'),
  outflow('Outflow'),
  pointsflow('Pointsflow');

  @override
  final String displayName;
  const HistoryTransactionType(this.displayName);
}
