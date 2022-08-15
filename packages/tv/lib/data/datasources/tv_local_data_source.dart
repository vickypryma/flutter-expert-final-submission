import 'package:core/utils/exception.dart';
import 'package:tv/data/models/tv_model.dart';

import 'db/tv_database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvModel tv);
  Future<String> removeWatchlist(TvModel tv);
  Future<TvModel?> getTvById(int id);
  Future<List<TvModel>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvModel tv) async {
    try {
      await databaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvModel tv) async {
    try {
      await databaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvModel?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvModel.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvModel>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvModel.fromJson(data)).toList();
  }
}
