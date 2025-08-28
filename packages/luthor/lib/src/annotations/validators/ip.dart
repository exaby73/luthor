import 'package:luthor/luthor.dart';

class IsIp {
  final IpVersion? version;
  final String? message;
  final String? Function()? messageFn;

  const IsIp({this.version, this.message, this.messageFn});
}
