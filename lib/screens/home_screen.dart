import 'package:flutter/material.dart';
import 'package:beeflix/models/movie_model.dart';
import 'package:beeflix/services/api_service.dart';
import 'package:beeflix/widgets/movie_widget.dart';

const POPULAR = 'Popular Movies';
const NOW = 'Now in Cinemas';
const COMING = 'Coming Soon';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> movies = ApiSerivce.getPopularMovies();
  final Future<List<MovieModel>> moviesNow = ApiSerivce.getMoviesNow();
  final Future<List<MovieModel>> moviesComing = ApiSerivce.getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              _buildFutureBuilder(movies, POPULAR),
              _buildFutureBuilder(moviesNow, NOW),
              _buildFutureBuilder(moviesComing, COMING),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<MovieModel>> _buildFutureBuilder(
      Future<List<MovieModel>> future, String movieTitle) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: movieTitle == POPULAR ? 200 : 300,
                  child: makeList(snapshot, movieTitle),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot, String movieTitle) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          title: movieTitle == POPULAR ? '' : movie.title,
          backdropPath: movieTitle == POPULAR ? movie.backdropPath : '',
          posterPath: movie.posterPath,
          id: movie.id,
          moiveWidth: movieTitle == POPULAR ? 300 : 150,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
