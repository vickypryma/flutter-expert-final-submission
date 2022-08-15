import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PosterList extends StatelessWidget {
  final String detailRoute;
  final int id;
  final String posterPath;

  const PosterList(
      {Key? key,
      required this.detailRoute,
      required this.id,
      required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            detailRoute,
            arguments: id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: '$baseImageUrl$posterPath',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
