import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/github/core/shared/providers.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/loading_repo_tile.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/repo_tile.dart';

class PaginatedReposListView extends StatelessWidget {
  const PaginatedReposListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(starredReposNotifierProvider);
      return ListView.builder(
        itemCount: state.map(
          initial: (_) => _.repos.entity.length,
          loadInProgress: (_) => _.repos.entity.length + _.itemsPerPage,
          loadSuccess: (_) => _.repos.entity.length,
          loadFailure: (_) => _.repos.entity.length + 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return state.map(
            initial: (_) => Container(),
            loadInProgress: (_) {
              if (index < _.repos.entity.length) {
                return ReposTile(
                  repo: _.repos.entity[index],
                );
              } else {
                return LoadingRepoTile();
              }
            },
            loadSuccess: (_) => ReposTile(
              repo: _.repos.entity[index],
            ),
            loadFailure: (_) => Container(),
          );
        },
      );
    });
  }
}
