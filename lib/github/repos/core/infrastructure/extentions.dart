import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';

extension DTOlistToFomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDormain()).toList();
  }
}
