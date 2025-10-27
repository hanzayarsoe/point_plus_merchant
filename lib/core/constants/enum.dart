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

enum DialogType { confirm, delete }
