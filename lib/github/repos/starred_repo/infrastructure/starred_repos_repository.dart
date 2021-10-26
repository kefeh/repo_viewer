import 'package:dartz/dartz.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_failure.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;

  StarredReposRepository(this._remoteService);

  Future<Either<GithubFailure, List<GithubRepo>>> getStarredReposPage(
    int page,
  ) async {}
}
