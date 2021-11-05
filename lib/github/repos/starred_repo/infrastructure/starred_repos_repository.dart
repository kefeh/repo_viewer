import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/dormain/fresh.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_failure.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/core/infrastructure/extentions.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_local_service.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;
  final StarredReposLocalService _localService;

  StarredReposRepository(this._remoteService, this._localService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
    int page,
  ) async {
    try {
      final remotePage = await _remoteService.getStarredRepos(page);
      return right(
        await remotePage.when(
          noConnection: () async => Fresh.no(
            await _localService.getPage(page).then(
                  (value) => value.toDomain(),
                ),
            isNextPageAvailable: page < await _localService.getLocalPageCount(),
          ),
          notModified: (maxPage) async => Fresh.yes(
            await _localService.getPage(page).then(
                  (value) => value.toDomain(),
                ),
            isNextPageAvailable: page < maxPage,
          ),
          withNewData: (data, maxPage) async {
            _localService.upsertPage(data, page);
            return Fresh.yes(
              data.toDomain(),
              isNextPageAvailable: page < maxPage,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(erroCode: e.errorCode));
    }
  }
}
