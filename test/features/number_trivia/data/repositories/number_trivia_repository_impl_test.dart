import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture_course/core/network/network_info.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/data_sources/number_trivia_remote_date_source.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd_clean_architecture_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  const tNumber = 1;
  const tNumberTriviaModel = NumberTriviaModel(text: "test", number: tNumber);
  const NumberTrivia tNumberTrivia = tNumberTriviaModel;

  late NumberTriviaRepositoryImpl repositoryImpl;

  late MockRemoteDataSource mockRemoteDataSource;

  late MockLocalDataSource mockLocalDataSource;

  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();

    mockLocalDataSource = MockLocalDataSource();

    mockNetworkInfo = MockNetworkInfo();

    repositoryImpl = NumberTriviaRepositoryImpl(
      numberTriviaLocalDataSource: mockLocalDataSource,
      numberTriviaRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  test("check two models for equality", () {
    expect(tNumberTriviaModel, equals(tNumberTrivia));
  });

  group('get concrete number trivia', () {
    test('should check if the devise is online', () {
      when(() => mockNetworkInfo.isConnected).thenAnswer((invocation) async => true);

      when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
          .thenAnswer((_) async => tNumberTriviaModel);

      when(() => mockLocalDataSource.getLastNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
          .thenAnswer((_) async => []);

      mockNetworkInfo.isConnected;

      verify(() => mockNetworkInfo.isConnected).called(1);
    });

    group('devise is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((invocation) async => true);
      });

      test('should return remote data when the call to remote data source is success', () async {
        when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
            .thenAnswer((_) async => tNumberTriviaModel);

        when(() => mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
            .thenAnswer((_) async => []);

        final res = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        expect(res, equals(const Right(tNumberTrivia)));

        verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).called(1);
      });
    });

    group('devise is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
