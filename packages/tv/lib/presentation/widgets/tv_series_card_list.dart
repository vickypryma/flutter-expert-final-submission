import 'package:core/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';
import '../pages/tv_detail_page.dart';

class TvSeriesCard extends StatelessWidget {
  final Tv tvSeries;

  const TvSeriesCard(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      detailRoute: TvDetailPage.routeName,
      id: tvSeries.id,
      title: tvSeries.name,
      overview: tvSeries.overview!,
      posterPath: tvSeries.posterPath!,
    );
  }
}
