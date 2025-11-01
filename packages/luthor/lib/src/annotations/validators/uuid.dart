class IsUuid {
  final String? message;
  final String? Function()? messageFn;

  const IsUuid({this.message, this.messageFn});
}

const isUuid = IsUuid();
