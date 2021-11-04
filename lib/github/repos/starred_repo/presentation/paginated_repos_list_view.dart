import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/github/core/shared/providers.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';
import 'package:repo_viewer/github/repos/starred_repo/application/starred_repos_notifier.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/failure_repo_tile.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/loading_repo_tile.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/repo_tile.dart';
import 'package:repo_viewer/github/repos/starred_repo/presentation/toast.dart';

class PaginatedReposListView extends StatefulWidget {
  const PaginatedReposListView({
    Key? key,
  }) : super(key: key);

  @override
  State<PaginatedReposListView> createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState extends State<PaginatedReposListView> {
  bool canLoadNextPage = false;
  bool hasAlreadyShownNoConnectionToast = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(starredReposNotifierProvider);
      return ProviderListener<StarredReposState>(
          onChange: (BuildContext context, state) {
            state.map(
              initial: (_) => canLoadNextPage = true,
              loadInProgress: (_) => canLoadNextPage = false,
              loadSuccess: (_) {
                if (!_.repos.isFresh && !hasAlreadyShownNoConnectionToast) {
                  hasAlreadyShownNoConnectionToast = true;
                  showNoConnectionToast(
                      "You're not online, some information may be outdated",
                      context);
                }
                canLoadNextPage = _.isNextPageAvailable;
              },
              loadFailure: (_) => canLoadNextPage = false,
            );
          },
          provider: starredReposNotifierProvider,
          child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                final metric = notification.metrics;
                final limit =
                    metric.maxScrollExtent - metric.viewportDimension / 3;

                if (canLoadNextPage && metric.pixels >= limit) {
                  canLoadNextPage = false;
                  context
                      .read(starredReposNotifierProvider.notifier)
                      .getNextStarredReposPage();
                }
                return false;
              },
              child: _PaginatedListView(state: state)));
    });
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final StarredReposState state;

  @override
  Widget build(BuildContext context) {
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
              return const LoadingRepoTile();
            }
          },
          loadSuccess: (_) => ReposTile(
            repo: _.repos.entity[index],
          ),
          loadFailure: (_) {
            if (index < _.repos.entity.length) {
              return ReposTile(
                repo: _.repos.entity[index],
              );
            } else {
              return FailureRepoTile(
                failure: _.failure,
              );
            }
          },
        );
      },
    );
  }
}
