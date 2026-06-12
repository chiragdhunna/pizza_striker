// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_device_token_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminDeviceTokenModel _$AdminDeviceTokenModelFromJson(
    Map<String, dynamic> json) {
  return _AdminDeviceTokenModel.fromJson(json);
}

/// @nodoc
mixin _$AdminDeviceTokenModel {
  String get deviceToken => throw _privateConstructorUsedError;

  /// Serializes this AdminDeviceTokenModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDeviceTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDeviceTokenModelCopyWith<AdminDeviceTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDeviceTokenModelCopyWith<$Res> {
  factory $AdminDeviceTokenModelCopyWith(AdminDeviceTokenModel value,
          $Res Function(AdminDeviceTokenModel) then) =
      _$AdminDeviceTokenModelCopyWithImpl<$Res, AdminDeviceTokenModel>;
  @useResult
  $Res call({String deviceToken});
}

/// @nodoc
class _$AdminDeviceTokenModelCopyWithImpl<$Res,
        $Val extends AdminDeviceTokenModel>
    implements $AdminDeviceTokenModelCopyWith<$Res> {
  _$AdminDeviceTokenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDeviceTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceToken = null,
  }) {
    return _then(_value.copyWith(
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminDeviceTokenModelImplCopyWith<$Res>
    implements $AdminDeviceTokenModelCopyWith<$Res> {
  factory _$$AdminDeviceTokenModelImplCopyWith(
          _$AdminDeviceTokenModelImpl value,
          $Res Function(_$AdminDeviceTokenModelImpl) then) =
      __$$AdminDeviceTokenModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deviceToken});
}

/// @nodoc
class __$$AdminDeviceTokenModelImplCopyWithImpl<$Res>
    extends _$AdminDeviceTokenModelCopyWithImpl<$Res,
        _$AdminDeviceTokenModelImpl>
    implements _$$AdminDeviceTokenModelImplCopyWith<$Res> {
  __$$AdminDeviceTokenModelImplCopyWithImpl(_$AdminDeviceTokenModelImpl _value,
      $Res Function(_$AdminDeviceTokenModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDeviceTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceToken = null,
  }) {
    return _then(_$AdminDeviceTokenModelImpl(
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDeviceTokenModelImpl
    with DiagnosticableTreeMixin
    implements _AdminDeviceTokenModel {
  const _$AdminDeviceTokenModelImpl({required this.deviceToken});

  factory _$AdminDeviceTokenModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDeviceTokenModelImplFromJson(json);

  @override
  final String deviceToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AdminDeviceTokenModel(deviceToken: $deviceToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AdminDeviceTokenModel'))
      ..add(DiagnosticsProperty('deviceToken', deviceToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDeviceTokenModelImpl &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deviceToken);

  /// Create a copy of AdminDeviceTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDeviceTokenModelImplCopyWith<_$AdminDeviceTokenModelImpl>
      get copyWith => __$$AdminDeviceTokenModelImplCopyWithImpl<
          _$AdminDeviceTokenModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDeviceTokenModelImplToJson(
      this,
    );
  }
}

abstract class _AdminDeviceTokenModel implements AdminDeviceTokenModel {
  const factory _AdminDeviceTokenModel({required final String deviceToken}) =
      _$AdminDeviceTokenModelImpl;

  factory _AdminDeviceTokenModel.fromJson(Map<String, dynamic> json) =
      _$AdminDeviceTokenModelImpl.fromJson;

  @override
  String get deviceToken;

  /// Create a copy of AdminDeviceTokenModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDeviceTokenModelImplCopyWith<_$AdminDeviceTokenModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
