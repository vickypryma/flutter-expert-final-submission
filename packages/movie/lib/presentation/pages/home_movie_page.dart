import 'package:core/core.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/presentation/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/presentation/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../domain/entities/movie.dart';
import 'movie_detail_page.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/movies';

  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies();
      context.read<PopularMoviesCubit>().fetchPopularMovies();
      context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Movies',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
                builder: (_, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesLoaded) {
                    return MovieList(state.result,
                        key: const Key('movie_list'));
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              SubHeading(
                key: const Key('see_popular_movies'),
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesLoaded) {
                    return MovieList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              SubHeading(
                key: const Key('see_top_rated_movies'),
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesLoaded) {
                    return MovieList(state.result);
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return PosterList(
            detailRoute: MovieDetailPage.routeName,
            id: movie.id,
            posterPath: movie.posterPath!,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
