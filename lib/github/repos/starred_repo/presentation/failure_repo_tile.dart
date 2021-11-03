import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/github/core/shared/providers.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_failure.dart';

class FailureRepoTile extends ConsumerWidget {
  final GithubFailure failure;
  const FailureRepoTile({
    Key? key,
    required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetReference ref) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      iconColor: Theme.of(context).colorScheme.onError,
      child: Card(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListTile(
          title: const Text('An error occured, please, retry'),
          subtitle: Text(
            failure.map(api: (_) => 'API returned ${_.erroCode}'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.warning,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                context
                    .read(starredReposNotifierProvider.notifier)
                    .getNextStarredReposPage();
              },
              icon: const Icon(Icons.refresh)),
        ),
      ),
    );
  }
}
