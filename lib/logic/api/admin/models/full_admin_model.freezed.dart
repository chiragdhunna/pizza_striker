// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_admin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FullAdminModel _$FullAdminModelFromJson(Map<String, dynamic> json) {
  return _FullAdminModel.fromJson(json);
}

/// @nodoc
mixin _$FullAdminModel {
  String get accessToken => throw _privateConstructorUsedError;
  AdminModel get admin => throw _privateConstructorUsedError;

  /// Serializes this FullAdminModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullAdminModelCopyWith<FullAdminModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullAdminModelCopyWith<$Res> {
  factory $FullAdminModelCopyWith(
          FullAdminModel value, $Res Function(FullAdminModel) then) =
      _$FullAdminModelCopyWithImpl<$Res, FullAdminModel>;
  @useResult
  $Res call({String accessToken, AdminModel admin});

  $AdminModelCopyWith<$Res> get admin;
}

/// @nodoc
class _$FullAdminModelCopyWithImpl<$Res, $Val extends FullAdminModel>
    implements $FullAdminModelCopyWith<$Res> {
  _$FullAdminModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? admin = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      admin: null == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as AdminModel,
    ) as $Val);
  }

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminModelCopyWith<$Res> get admin {
    return $AdminModelCopyWith<$Res>(_value.admin, (value) {
      return _then(_value.copyWith(admin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FullAdminModelImplCopyWith<$Res>
    implements $FullAdminModelCopyWith<$Res> {
  factory _$$FullAdminModelImplCopyWith(_$FullAdminModelImpl value,
          $Res Function(_$FullAdminModelImpl) then) =
      __$$FullAdminModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, AdminModel admin});

  @override
  $AdminModelCopyWith<$Res> get admin;
}

/// @nodoc
class __$$FullAdminModelImplCopyWithImpl<$Res>
    extends _$FullAdminModelCopyWithImpl<$Res, _$FullAdminModelImpl>
    implements _$$FullAdminModelImplCopyWith<$Res> {
  __$$FullAdminModelImplCopyWithImpl(
      _$FullAdminModelImpl _value, $Res Function(_$FullAdminModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? admin = null,
  }) {
    return _then(_$FullAdminModelImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      admin: null == admin
          ? _value.admin
          : admin // ignore: cast_nullable_to_non_nullable
              as AdminModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FullAdminModelImpl
    with DiagnosticableTreeMixin
    implements _FullAdminModel {
  const _$FullAdminModelImpl({required this.accessToken, required this.admin});

  factory _$FullAdminModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullAdminModelImplFromJson(json);

  @override
  final String accessToken;
  @override
  final AdminModel admin;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FullAdminModel(accessToken: $accessToken, admin: $admin)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FullAdminModel'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('admin', admin));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullAdminModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.admin, admin) || other.admin == admin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, admin);

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullAdminModelImplCopyWith<_$FullAdminModelImpl> get copyWith =>
      __$$FullAdminModelImplCopyWithImpl<_$FullAdminModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullAdminModelImplToJson(
      this,
    );
  }
}

abstract class _FullAdminModel implements FullAdminModel {
  const factory _FullAdminModel(
      {required final String accessToken,
      required final AdminModel admin}) = _$FullAdminModelImpl;

  factory _FullAdminModel.fromJson(Map<String, dynamic> json) =
      _$FullAdminModelImpl.fromJson;

  @override
  String get accessToken;
  @override
  AdminModel get admin;

  /// Create a copy of FullAdminModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullAdminModelImplCopyWith<_$FullAdminModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
