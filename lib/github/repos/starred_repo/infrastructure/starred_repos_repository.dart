import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/dormain/fresh.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_failure.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/starred_repo/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;

  StarredReposRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
    int page,
  ) async {
    try {
      final remote_page = await _remoteService.getStarredRepos(page);
      return right(remote_page.when(

          // Todo Local service
          noConnection: (maxPage) => Fresh.no(
                [],
                isNextPageAvailable: page < maxPage,
              ),

          // Todo Local service
          notModified: (maxPage) => Fresh.yes(
                [],
                isNextPageAvailable: page < maxPage,
              ),
          withNewData: (data, maxPage) {
            // Todo Local service
            return Fresh.yes(
              data.toDomain(),
              isNextPageAvailable: page < maxPage,
            );
          }));
    } on RestApiException catch (e) {
      return left(GithubFailure.api(erroCode: e.errorCode));
    }
  }
}

extension DTOlistToFomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDormain()).toList();
  }
}
