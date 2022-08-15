import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Map<String, WidgetBuilder> pages;

  const CustomDrawer({Key? key, required this.pages}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late String _activePage;

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  void changeContent(String route) {
    toggle();
    setState(() {
      _activePage = route;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _activePage = widget.pages.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.pages[_activePage]!(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      key: const Key('drawer'),
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            key: const Key('movie_list_tile'),
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              changeContent(movieRoute);
            },
          ),
          ListTile(
            key: const Key('tv_list_tile'),
            leading: const Icon(Icons.live_tv),
            title: const Text('TV Series'),
            onTap: () {
              changeContent(tvRoute);
            },
          ),
          ListTile(
            key: const Key('watchlist_list_tile'),
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              changeContent(watchlistRoute);
            },
          ),
          ListTile(
            key: const Key('about_list_tile'),
            onTap: () {
              toggle();
              Navigator.pushNamed(context, aboutRoute);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
