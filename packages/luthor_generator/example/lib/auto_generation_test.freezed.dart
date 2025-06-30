// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_generation_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExternalUser {
  String get name;
  String get email;
  int? get age;

  /// Create a copy of ExternalUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExternalUserCopyWith<ExternalUser> get copyWith =>
      _$ExternalUserCopyWithImpl<ExternalUser>(
          this as ExternalUser, _$identity);

  /// Serializes this ExternalUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExternalUser &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, age);

  @override
  String toString() {
    return 'ExternalUser(name: $name, email: $email, age: $age)';
  }
}

/// @nodoc
abstract mixin class $ExternalUserCopyWith<$Res> {
  factory $ExternalUserCopyWith(
          ExternalUser value, $Res Function(ExternalUser) _then) =
      _$ExternalUserCopyWithImpl;
  @useResult
  $Res call({String name, String email, int? age});
}

/// @nodoc
class _$ExternalUserCopyWithImpl<$Res> implements $ExternalUserCopyWith<$Res> {
  _$ExternalUserCopyWithImpl(this._self, this._then);

  final ExternalUser _self;
  final $Res Function(ExternalUser) _then;

  /// Create a copy of ExternalUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? age = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ExternalUser implements ExternalUser {
  const _ExternalUser({required this.name, required this.email, this.age});
  factory _ExternalUser.fromJson(Map<String, dynamic> json) =>
      _$ExternalUserFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final int? age;

  /// Create a copy of ExternalUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExternalUserCopyWith<_ExternalUser> get copyWith =>
      __$ExternalUserCopyWithImpl<_ExternalUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExternalUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExternalUser &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, age);

  @override
  String toString() {
    return 'ExternalUser(name: $name, email: $email, age: $age)';
  }
}

/// @nodoc
abstract mixin class _$ExternalUserCopyWith<$Res>
    implements $ExternalUserCopyWith<$Res> {
  factory _$ExternalUserCopyWith(
          _ExternalUser value, $Res Function(_ExternalUser) _then) =
      __$ExternalUserCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String email, int? age});
}

/// @nodoc
class __$ExternalUserCopyWithImpl<$Res>
    implements _$ExternalUserCopyWith<$Res> {
  __$ExternalUserCopyWithImpl(this._self, this._then);

  final _ExternalUser _self;
  final $Res Function(_ExternalUser) _then;

  /// Create a copy of ExternalUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? age = freezed,
  }) {
    return _then(_ExternalUser(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$UserProfile {
  int get id;
  ExternalUser get user;
  ExternalUser? get user2;
  List<ExternalUser>? get friends;
  List<String> get tags;
  DateTime get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<UserProfile> get copyWith =>
      _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.user2, user2) || other.user2 == user2) &&
            const DeepCollectionEquality().equals(other.friends, friends) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user,
      user2,
      const DeepCollectionEquality().hash(friends),
      const DeepCollectionEquality().hash(tags),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'UserProfile(id: $id, user: $user, user2: $user2, friends: $friends, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) _then) =
      _$UserProfileCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      ExternalUser user,
      ExternalUser? user2,
      List<ExternalUser>? friends,
      List<String> tags,
      DateTime createdAt,
      DateTime? updatedAt});

  $ExternalUserCopyWith<$Res> get user;
  $ExternalUserCopyWith<$Res>? get user2;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? user2 = freezed,
    Object? friends = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExternalUser,
      user2: freezed == user2
          ? _self.user2
          : user2 // ignore: cast_nullable_to_non_nullable
              as ExternalUser?,
      friends: freezed == friends
          ? _self.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<ExternalUser>?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalUserCopyWith<$Res> get user {
    return $ExternalUserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalUserCopyWith<$Res>? get user2 {
    if (_self.user2 == null) {
      return null;
    }

    return $ExternalUserCopyWith<$Res>(_self.user2!, (value) {
      return _then(_self.copyWith(user2: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _UserProfile implements UserProfile {
  const _UserProfile(
      {required this.id,
      required this.user,
      this.user2,
      final List<ExternalUser>? friends,
      required final List<String> tags,
      required this.createdAt,
      this.updatedAt})
      : _friends = friends,
        _tags = tags;
  factory _UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  final int id;
  @override
  final ExternalUser user;
  @override
  final ExternalUser? user2;
  final List<ExternalUser>? _friends;
  @override
  List<ExternalUser>? get friends {
    final value = _friends;
    if (value == null) return null;
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserProfileCopyWith<_UserProfile> get copyWith =>
      __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.user2, user2) || other.user2 == user2) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user,
      user2,
      const DeepCollectionEquality().hash(_friends),
      const DeepCollectionEquality().hash(_tags),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'UserProfile(id: $id, user: $user, user2: $user2, friends: $friends, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(
          _UserProfile value, $Res Function(_UserProfile) _then) =
      __$UserProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      ExternalUser user,
      ExternalUser? user2,
      List<ExternalUser>? friends,
      List<String> tags,
      DateTime createdAt,
      DateTime? updatedAt});

  @override
  $ExternalUserCopyWith<$Res> get user;
  @override
  $ExternalUserCopyWith<$Res>? get user2;
}

/// @nodoc
class __$UserProfileCopyWithImpl<$Res> implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? user2 = freezed,
    Object? friends = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_UserProfile(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExternalUser,
      user2: freezed == user2
          ? _self.user2
          : user2 // ignore: cast_nullable_to_non_nullable
              as ExternalUser?,
      friends: freezed == friends
          ? _self._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<ExternalUser>?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalUserCopyWith<$Res> get user {
    return $ExternalUserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalUserCopyWith<$Res>? get user2 {
    if (_self.user2 == null) {
      return null;
    }

    return $ExternalUserCopyWith<$Res>(_self.user2!, (value) {
      return _then(_self.copyWith(user2: value));
    });
  }
}

// dart format on
