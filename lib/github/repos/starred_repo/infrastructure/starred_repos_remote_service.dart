import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio = Dio();

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredRepos(int page) async {}
}
