import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/blocs/airing_today_tv/airing_today_tv_cubit.dart';

import '../widgets/tv_series_card_list.dart';

class AiringTodayTvPage extends StatefulWidget {
  static const routeName = '/airing-today-tv';

  const AiringTodayTvPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayTvPage> createState() => _AiringTodayTvPageState();
}

class _AiringTodayTvPageState extends State<AiringTodayTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<AiringTodayTvCubit>().fetchAiringTodayTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvCubit, AiringTodayTvState>(
          builder: (context, state) {
            if (state is AiringTodayTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvLoaded) {
              return ListView.builder(
                key: const Key('airing_tv_listview'),
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return TvSeriesCard(tvSeries);
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
