import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/core/shared/providers.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/github/repos/starred_repo/application/starred_repos_notifier.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_local_service.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_remote_service.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_repository.dart';

final starredReposLocalServiceProvider = Provider(
  (ref) => StarredReposLocalService(
    ref.watch(sembastProvider),
  ),
);

final githubHeadersCacheProvider = Provider(
  (ref) => GithubHeadersCache(
    ref.watch(sembastProvider),
  ),
);

final starredReposRemoteServiceProvider = Provider(
  (ref) => StarredReposRemoteService(
    ref.watch(githubHeadersCacheProvider),
  ),
);

final starredReposRepositoryProvider = Provider(
  (ref) => StarredReposRepository(
    ref.watch(starredReposRemoteServiceProvider),
    ref.watch(starredReposLocalServiceProvider),
  ),
);

final starredReposNotifierProvider =
    StateNotifierProvider<StarredReposNotifier, StarredReposState>(
  (ref) => StarredReposNotifier(
    ref.watch(starredReposRepositoryProvider),
  ),
);
