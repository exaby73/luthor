class IsFile {
  final String? message;
  final String? Function()? messageFn;

  const IsFile({this.message, this.messageFn});
}

const isFile = IsFile();
