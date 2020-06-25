import 'package:flutter/material.dart';
import 'package:task/mocks/mocks.dart';
import 'package:task/models/Movie.dart';
import 'package:task/view_models/MainPageViewModel.dart';
import 'package:task/views/pages/mainPage.dart';
import 'package:task/views/widgets/movie_list_item.dart';
import 'package:task/views/widgets/no_internet_connection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  final MockSwapiService svc = MockSwapiService();
  final MainPageViewModel vm = MainPageViewModel(apiSvc: svc);
  final MaterialApp app = MaterialApp(home: MainPage(viewModel: vm));

  testWidgets('Render list of Movies', (WidgetTester tester) async {
    when(svc.getNowPlayingMovies()).thenAnswer((_) {
      List<Movie> Movies = List<Movie>();
      Movies.add(Movie()
        ..title = 'Love Me');
      Movies.add(Movie()
        ..title = 'How I meet your mother');

      return Future.value(Movies);
    });

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(Duration(seconds: 5));

    expect(find.byType(MoviesListItem), findsNWidgets(2));
  });

  testWidgets('Renders Movies tab error widget', (WidgetTester tester) async {
    when(svc.getNowPlayingMovies()).thenAnswer((_) {
      return Future.error(Exception);
    });

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(Duration(seconds: 5));

    expect(find.byType(NoInternetConnection), findsOneWidget);
  });
}
