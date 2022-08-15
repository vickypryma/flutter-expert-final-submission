import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/widgets/tv_series_card_list.dart';

import 'blocs/search_cubit.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('search_text_field'),
              onChanged: (query) {
                context.read<SearchCubit>().onQueryChange(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) => Row(
                children: [
                  Radio(
                    key: const Key('movie_radio'),
                    value: true,
                    groupValue: state.isMovie,
                    onChanged: (bool? value) {
                      context.read<SearchCubit>().changeType(value!);
                    },
                  ),
                  Text('Movie', style: kSubtitle),
                  Radio(
                    key: const Key('tv_radio'),
                    value: false,
                    groupValue: state.isMovie,
                    onChanged: (bool? value) {
                      context.read<SearchCubit>().changeType(value!);
                    },
                  ),
                  Text('TV Series', style: kSubtitle),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchLoaded) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final data = result[index];
                        return state.isMovie
                            ? MovieCard(data)
                            : TvSeriesCard(data);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
