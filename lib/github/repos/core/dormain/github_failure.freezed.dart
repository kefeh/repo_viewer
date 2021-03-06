// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'github_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GithubFailureTearOff {
  const _$GithubFailureTearOff();

  _Api api({int? erroCode}) {
    return _Api(
      erroCode: erroCode,
    );
  }
}

/// @nodoc
const $GithubFailure = _$GithubFailureTearOff();

/// @nodoc
mixin _$GithubFailure {
  int? get erroCode => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? erroCode) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? erroCode)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubFailureCopyWith<GithubFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubFailureCopyWith<$Res> {
  factory $GithubFailureCopyWith(
          GithubFailure value, $Res Function(GithubFailure) then) =
      _$GithubFailureCopyWithImpl<$Res>;
  $Res call({int? erroCode});
}

/// @nodoc
class _$GithubFailureCopyWithImpl<$Res>
    implements $GithubFailureCopyWith<$Res> {
  _$GithubFailureCopyWithImpl(this._value, this._then);

  final GithubFailure _value;
  // ignore: unused_field
  final $Res Function(GithubFailure) _then;

  @override
  $Res call({
    Object? erroCode = freezed,
  }) {
    return _then(_value.copyWith(
      erroCode: erroCode == freezed
          ? _value.erroCode
          : erroCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$ApiCopyWith<$Res> implements $GithubFailureCopyWith<$Res> {
  factory _$ApiCopyWith(_Api value, $Res Function(_Api) then) =
      __$ApiCopyWithImpl<$Res>;
  @override
  $Res call({int? erroCode});
}

/// @nodoc
class __$ApiCopyWithImpl<$Res> extends _$GithubFailureCopyWithImpl<$Res>
    implements _$ApiCopyWith<$Res> {
  __$ApiCopyWithImpl(_Api _value, $Res Function(_Api) _then)
      : super(_value, (v) => _then(v as _Api));

  @override
  _Api get _value => super._value as _Api;

  @override
  $Res call({
    Object? erroCode = freezed,
  }) {
    return _then(_Api(
      erroCode: erroCode == freezed
          ? _value.erroCode
          : erroCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_Api extends _Api {
  const _$_Api({this.erroCode}) : super._();

  @override
  final int? erroCode;

  @override
  String toString() {
    return 'GithubFailure.api(erroCode: $erroCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Api &&
            (identical(other.erroCode, erroCode) ||
                const DeepCollectionEquality()
                    .equals(other.erroCode, erroCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(erroCode);

  @JsonKey(ignore: true)
  @override
  _$ApiCopyWith<_Api> get copyWith =>
      __$ApiCopyWithImpl<_Api>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? erroCode) api,
  }) {
    return api(erroCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? erroCode)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(erroCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Api value) api,
  }) {
    return api(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Api value)? api,
    required TResult orElse(),
  }) {
    if (api != null) {
      return api(this);
    }
    return orElse();
  }
}

abstract class _Api extends GithubFailure {
  const factory _Api({int? erroCode}) = _$_Api;
  const _Api._() : super._();

  @override
  int? get erroCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ApiCopyWith<_Api> get copyWith => throw _privateConstructorUsedError;
}
