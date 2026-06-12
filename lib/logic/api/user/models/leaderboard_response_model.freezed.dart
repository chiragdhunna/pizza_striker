// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaderBoardResponseModel _$LeaderBoardResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LeaderBoardResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderBoardResponseModel {
  List<FullUserModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  int get pages => throw _privateConstructorUsedError;

  /// Serializes this LeaderBoardResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderBoardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderBoardResponseModelCopyWith<LeaderBoardResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderBoardResponseModelCopyWith<$Res> {
  factory $LeaderBoardResponseModelCopyWith(LeaderBoardResponseModel value,
          $Res Function(LeaderBoardResponseModel) then) =
      _$LeaderBoardResponseModelCopyWithImpl<$Res, LeaderBoardResponseModel>;
  @useResult
  $Res call(
      {List<FullUserModel> items, int total, int page, int size, int pages});
}

/// @nodoc
class _$LeaderBoardResponseModelCopyWithImpl<$Res,
        $Val extends LeaderBoardResponseModel>
    implements $LeaderBoardResponseModelCopyWith<$Res> {
  _$LeaderBoardResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderBoardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? size = null,
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FullUserModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderBoardResponseModelImplCopyWith<$Res>
    implements $LeaderBoardResponseModelCopyWith<$Res> {
  factory _$$LeaderBoardResponseModelImplCopyWith(
          _$LeaderBoardResponseModelImpl value,
          $Res Function(_$LeaderBoardResponseModelImpl) then) =
      __$$LeaderBoardResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FullUserModel> items, int total, int page, int size, int pages});
}

/// @nodoc
class __$$LeaderBoardResponseModelImplCopyWithImpl<$Res>
    extends _$LeaderBoardResponseModelCopyWithImpl<$Res,
        _$LeaderBoardResponseModelImpl>
    implements _$$LeaderBoardResponseModelImplCopyWith<$Res> {
  __$$LeaderBoardResponseModelImplCopyWithImpl(
      _$LeaderBoardResponseModelImpl _value,
      $Res Function(_$LeaderBoardResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderBoardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? size = null,
    Object? pages = null,
  }) {
    return _then(_$LeaderBoardResponseModelImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FullUserModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderBoardResponseModelImpl
    with DiagnosticableTreeMixin
    implements _LeaderBoardResponseModel {
  const _$LeaderBoardResponseModelImpl(
      {required final List<FullUserModel> items,
      required this.total,
      required this.page,
      required this.size,
      required this.pages})
      : _items = items;

  factory _$LeaderBoardResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderBoardResponseModelImplFromJson(json);

  final List<FullUserModel> _items;
  @override
  List<FullUserModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int size;
  @override
  final int pages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LeaderBoardResponseModel(items: $items, total: $total, page: $page, size: $size, pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LeaderBoardResponseModel'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderBoardResponseModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.pages, pages) || other.pages == pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), total, page, size, pages);

  /// Create a copy of LeaderBoardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderBoardResponseModelImplCopyWith<_$LeaderBoardResponseModelImpl>
      get copyWith => __$$LeaderBoardResponseModelImplCopyWithImpl<
          _$LeaderBoardResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderBoardResponseModelImplToJson(
      this,
    );
  }
}

abstract class _LeaderBoardResponseModel implements LeaderBoardResponseModel {
  const factory _LeaderBoardResponseModel(
      {required final List<FullUserModel> items,
      required final int total,
      required final int page,
      required final int size,
      required final int pages}) = _$LeaderBoardResponseModelImpl;

  factory _LeaderBoardResponseModel.fromJson(Map<String, dynamic> json) =
      _$LeaderBoardResponseModelImpl.fromJson;

  @override
  List<FullUserModel> get items;
  @override
  int get total;
  @override
  int get page;
  @override
  int get size;
  @override
  int get pages;

  /// Create a copy of LeaderBoardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderBoardResponseModelImplCopyWith<_$LeaderBoardResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
