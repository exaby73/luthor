class IsEmail {
  final String? message;
  final String? Function()? messageFn;

  const IsEmail({this.message, this.messageFn});
}

const isEmail = IsEmail();
