// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostViewModel)
const postViewModelProvider = PostViewModelProvider._();

final class PostViewModelProvider
    extends $AsyncNotifierProvider<PostViewModel, List<PostEntity>> {
  const PostViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postViewModelHash();

  @$internal
  @override
  PostViewModel create() => PostViewModel();
}

String _$postViewModelHash() => r'040d394bdad109e8714894db1ac456a4a620b505';

abstract class _$PostViewModel extends $AsyncNotifier<List<PostEntity>> {
  FutureOr<List<PostEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<PostEntity>>, List<PostEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PostEntity>>, List<PostEntity>>,
              AsyncValue<List<PostEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(bookmarkedPosts)
const bookmarkedPostsProvider = BookmarkedPostsProvider._();

final class BookmarkedPostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostEntity>>,
          List<PostEntity>,
          FutureOr<List<PostEntity>>
        >
    with $FutureModifier<List<PostEntity>>, $FutureProvider<List<PostEntity>> {
  const BookmarkedPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkedPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkedPostsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostEntity>> create(Ref ref) {
    return bookmarkedPosts(ref);
  }
}

String _$bookmarkedPostsHash() => r'6a3f3e0a10c2efa5faf7ba1ec43afb66ad5a9439';

@ProviderFor(myPosts)
const myPostsProvider = MyPostsProvider._();

final class MyPostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostEntity>>,
          List<PostEntity>,
          FutureOr<List<PostEntity>>
        >
    with $FutureModifier<List<PostEntity>>, $FutureProvider<List<PostEntity>> {
  const MyPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPostsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostEntity>> create(Ref ref) {
    return myPosts(ref);
  }
}

String _$myPostsHash() => r'462bc757805157776a3c4e4887567ba93b059dce';
