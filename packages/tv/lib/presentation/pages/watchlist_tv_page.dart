import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/blocs/watchlist_tv/watchlist_tv_cubit.dart';

import '../widgets/tv_series_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistTvCubit>().fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvCubit>().fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvCubit, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvLoaded) {
            return ListView.builder(
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
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
