import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: '$baseImageUrl${episode.stillPath}',
            width: 100,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              height: 50,
              width: 100,
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.image),
              ),
            ),
          ),
        ),
        title: Text(
          episode.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: kHeading6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              episode.overview == '' ? 'No information' : episode.overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
