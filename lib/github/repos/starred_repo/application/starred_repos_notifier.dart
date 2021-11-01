import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/core/dormain/fresh.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_failure.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_repository.dart';
part 'starred_repos_notifier.freezed.dart';

@freezed
class StarredReposState with _$StarredReposState {
  const StarredReposState._();
  const factory StarredReposState.initial(
    Fresh<List<GithubRepo>> repos,
  ) = _Initial;
  const factory StarredReposState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
    int itemsPerPage,
  ) = _LoadInProgress;
  const factory StarredReposState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory StarredReposState.loadFailure(
    Fresh<List<GithubRepo>> repos,
    GithubFailure failure,
  ) = _LoadFailure;
}

class StarredReposNotifier extends StateNotifier<StarredReposState> {
  final StarredReposRepository _repository;

  StarredReposNotifier(this._repository)
      : super(StarredReposState.initial(Fresh.yes([])));
  int _page = 1;
}
