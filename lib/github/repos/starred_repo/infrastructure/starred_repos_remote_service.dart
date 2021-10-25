import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';

class StarredReposRemoteService {
  final Dio _dio = Dio();
  final GithubHeadersCache _headersCache;

  StarredReposRemoteService(this._headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredRepos(
    int page,
  ) async {
    const token = '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';
    const accept = 'application/vnd.github.v3.html+json';
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {'page': '$page'},
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'Authorization': 'bearer $token',
            'Accept': accept,
            'If-None-Match': previousHeaders?.etag ?? '',
          },
        ),
      );
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
