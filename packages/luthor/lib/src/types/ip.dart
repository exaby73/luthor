/// An IP address version, for `l.string().ip(version: ...)`.
enum IpVersion {
  /// IPv4, such as `192.168.1.1`.
  v4,

  /// IPv6, such as `2001:db8::1`.
  v6,
}
