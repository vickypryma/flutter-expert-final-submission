import 'package:core/styles/text_styles.dart';
import 'package:core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Watchlist',
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
                labelStyle: kSubtitle,
                tabs: const [
                  Text('Movies', key: Key('movies_tab')),
                  Text('TV Series', key: Key('tv_tab')),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  WatchlistMoviesPage(),
                  WatchlistTvPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
