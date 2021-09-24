import 'package:dio/dio.dart';
import 'package:repo_viewer/github/repos/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;

  Future<List<GithubRepoDTO>> getStarredRepos(int page) async {}
}
