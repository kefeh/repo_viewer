import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:repo_viewer/github/repos/core/dormain/github_repo.dart';

class ReposTile extends StatelessWidget {
  final GithubRepo repo;
  const ReposTile({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repo.name),
      subtitle: Text(
        repo.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(
          repo.owner.avatarUrlSmall,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_border_outlined),
          Text(
            repo.stargazersCount.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
      onTap: () {},
    );
  }
}
