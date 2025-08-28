class IsUrl {
  final List<String>? allowedSchemes;
  final String? message;
  final String? Function()? messageFn;

  const IsUrl({this.allowedSchemes, this.message, this.messageFn});
}

const isUrl = IsUrl();
