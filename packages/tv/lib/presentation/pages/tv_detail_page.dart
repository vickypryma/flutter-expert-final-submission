import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/blocs/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/blocs/tv_watchlist_status/tv_watchlist_status_cubit.dart';
import 'package:tv/presentation/pages/season_episodes_page.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/tv-detail';

  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailCubit>().fetchTvDetail(widget.id);
      context.read<TvWatchlistStatusCubit>().loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            final tvSeries = state.tv;
            return SafeArea(
              child: DetailContent(
                tvSeries,
                state.recommendationTv,
              ),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvSeries;
  final List<Tv> recommendationTv;

  const DetailContent(this.tvSeries, this.recommendationTv, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        key: const Key('tv_detail_content'),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            _buildWatchlistButton(
                              context,
                              tvSeries,
                              () => _showMessage(context),
                            ),
                            Text(
                              _showGenres(tvSeries.genres!),
                            ),
                            Text(
                              _showDuration(tvSeries.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            const SizedBox(height: 16),
                            tvSeries.seasons.isNotEmpty
                                ? Text(
                                    'Seasons',
                                    style: kHeading6,
                                  )
                                : Container(),
                            tvSeries.seasons.isNotEmpty
                                ? SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season = tvSeries.seasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                SeasonEpisodesPage.routeName,
                                                arguments: {
                                                  'id': tvSeries.id,
                                                  'season': season.seasonNumber,
                                                },
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black54,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Season ${season.seasonNumber}',
                                                    style: kSubtitle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: tvSeries.seasons.length,
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvSeries = recommendationTv[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.routeName,
                                          arguments: tvSeries.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendationTv.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('back_button'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void _showMessage(BuildContext context) {
    final message = context.read<TvWatchlistStatusCubit>().state.message;
    if (message == TvWatchlistStatusCubit.watchlistAddSuccessMessage ||
        message == TvWatchlistStatusCubit.watchlistRemoveSuccessMessage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    }
  }

  Widget _buildWatchlistButton(
    BuildContext context,
    TvDetail tv,
    Function() showMessage,
  ) {
    return BlocBuilder<TvWatchlistStatusCubit, TvWatchlistStatusState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('watchlist_button'),
          onPressed: () async {
            if (!state.isAddedToWatchlist) {
              await context.read<TvWatchlistStatusCubit>().addWatchlist(tv);
            } else {
              await context
                  .read<TvWatchlistStatusCubit>()
                  .removeFromWatchlist(tv);
            }
            showMessage();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              state.isAddedToWatchlist
                  ? const Icon(Icons.check)
                  : const Icon(Icons.add),
              const Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> runtimes) {
    final runtime = runtimes.isNotEmpty ? runtimes[0] : 30;

    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
