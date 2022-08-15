import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/blocs/season_episodes/season_episodes_cubit.dart';

import '../widgets/episode_card_list.dart';

class SeasonEpisodesPage extends StatefulWidget {
  static const routeName = '/season-episodes';

  final int id;
  final int season;

  const SeasonEpisodesPage({Key? key, required this.id, required this.season})
      : super(key: key);

  @override
  State<SeasonEpisodesPage> createState() => _SeasonEpisodesPageState();
}

class _SeasonEpisodesPageState extends State<SeasonEpisodesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context
          .read<SeasonEpisodesCubit>()
          .fetchEpisodes(widget.id, widget.season),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Season Episodes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: BlocBuilder<SeasonEpisodesCubit, SeasonEpisodesState>(
          builder: (context, state) {
            if (state is SeasonEpisodesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeasonEpisodesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final episode = state.result[index];
                  return EpisodeCard(episode: episode);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}
