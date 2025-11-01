class IsEmoji {
  final String? message;
  final String? Function()? messageFn;

  const IsEmoji({this.message, this.messageFn});
}

const isEmoji = IsEmoji();
