// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FullUserModel _$FullUserModelFromJson(Map<String, dynamic> json) {
  return _FullUserModel.fromJson(json);
}

/// @nodoc
mixin _$FullUserModel {
  String get accessToken => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;

  /// Serializes this FullUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullUserModelCopyWith<FullUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullUserModelCopyWith<$Res> {
  factory $FullUserModelCopyWith(
          FullUserModel value, $Res Function(FullUserModel) then) =
      _$FullUserModelCopyWithImpl<$Res, FullUserModel>;
  @useResult
  $Res call({String accessToken, UserModel? user});

  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$FullUserModelCopyWithImpl<$Res, $Val extends FullUserModel>
    implements $FullUserModelCopyWith<$Res> {
  _$FullUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FullUserModelImplCopyWith<$Res>
    implements $FullUserModelCopyWith<$Res> {
  factory _$$FullUserModelImplCopyWith(
          _$FullUserModelImpl value, $Res Function(_$FullUserModelImpl) then) =
      __$$FullUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, UserModel? user});

  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$FullUserModelImplCopyWithImpl<$Res>
    extends _$FullUserModelCopyWithImpl<$Res, _$FullUserModelImpl>
    implements _$$FullUserModelImplCopyWith<$Res> {
  __$$FullUserModelImplCopyWithImpl(
      _$FullUserModelImpl _value, $Res Function(_$FullUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? user = freezed,
  }) {
    return _then(_$FullUserModelImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FullUserModelImpl
    with DiagnosticableTreeMixin
    implements _FullUserModel {
  const _$FullUserModelImpl({required this.accessToken, this.user});

  factory _$FullUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullUserModelImplFromJson(json);

  @override
  final String accessToken;
  @override
  final UserModel? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FullUserModel(accessToken: $accessToken, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FullUserModel'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullUserModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, user);

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullUserModelImplCopyWith<_$FullUserModelImpl> get copyWith =>
      __$$FullUserModelImplCopyWithImpl<_$FullUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullUserModelImplToJson(
      this,
    );
  }
}

abstract class _FullUserModel implements FullUserModel {
  const factory _FullUserModel(
      {required final String accessToken,
      final UserModel? user}) = _$FullUserModelImpl;

  factory _FullUserModel.fromJson(Map<String, dynamic> json) =
      _$FullUserModelImpl.fromJson;

  @override
  String get accessToken;
  @override
  UserModel? get user;

  /// Create a copy of FullUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullUserModelImplCopyWith<_$FullUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
