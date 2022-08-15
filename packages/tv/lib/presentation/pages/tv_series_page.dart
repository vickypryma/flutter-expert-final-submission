import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';
import 'package:tv/presentation/blocs/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/blocs/top_rated_tv/top_rated_tv_cubit.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../domain/entities/tv.dart';
import 'airing_today_tv_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const routeName = '/tv';

  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodayTvCubit>().fetchAiringTodayTv();
      context.read<PopularTvCubit>().fetchPopularTv();
      context.read<TopRatedTvCubit>().fetchTopRatedTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'TV Series',
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SubHeading(
                key: const Key('see_airing_tv'),
                title: 'Airing Today',
                onTap: () {
                  Navigator.pushNamed(context, AiringTodayTvPage.routeName);
                },
              ),
              BlocBuilder<AiringTodayTvCubit, AiringTodayTvState>(
                builder: (context, state) {
                  if (state is AiringTodayTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AiringTodayTvLoaded) {
                    return TvSeriesList(state.result,
                        key: const Key('tv_list'));
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              SubHeading(
                key: const Key('see_popular_tv'),
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvPage.routeName);
                },
              ),
              BlocBuilder<PopularTvCubit, PopularTvState>(
                builder: (context, state) {
                  if (state is PopularTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvLoaded) {
                    return TvSeriesList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              SubHeading(
                key: const Key('see_top_rated_tv'),
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvPage.routeName);
                },
              ),
              BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvLoaded) {
                    return TvSeriesList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<Tv> tvSeries;

  const TvSeriesList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return PosterList(
            detailRoute: TvDetailPage.routeName,
            id: series.id,
            posterPath: series.posterPath!,
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
