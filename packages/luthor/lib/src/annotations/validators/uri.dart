class IsUri {
  final List<String>? allowedSchemes;
  final String? message;
  final String? Function()? messageFn;

  const IsUri({this.allowedSchemes, this.message, this.messageFn});
}

const isUri = IsUri();
