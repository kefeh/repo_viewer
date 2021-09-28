import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio = Dio();
  final GithubHeadersCache _headersCache;

  StarredReposRemoteService(this._headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredRepos(int page) async {}
}
