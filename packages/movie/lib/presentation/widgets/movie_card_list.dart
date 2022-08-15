import 'package:core/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie_detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      detailRoute: MovieDetailPage.routeName,
      id: movie.id,
      title: movie.title!,
      overview: movie.overview!,
      posterPath: movie.posterPath!,
    );
  }
}
