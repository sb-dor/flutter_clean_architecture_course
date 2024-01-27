import 'package:flutter_tdd_clean_architecture_course/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MockConnectivityPlus extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivityPlus mockConnectivityPlus;

  setUp(() {
    mockConnectivityPlus = MockConnectivityPlus();
    networkInfoImpl = NetworkInfoImpl(mockConnectivityPlus);
  });

  const bool tTrue = true;
  const bool tFalse = false;

  group('isConnected', () {
    test('should check the connection and return true', () async {
      when(() => mockConnectivityPlus.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.mobile);

      final result = await networkInfoImpl.isConnected;

      expect(result, tTrue);

      verify(() => mockConnectivityPlus.checkConnectivity()).called(1);
    });

    test('should check the connection and return true', () async{
      when(() => mockConnectivityPlus.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      final result = await networkInfoImpl.isConnected;

      expect(result, tFalse);

      verify(() => mockConnectivityPlus.checkConnectivity()).called(1);
    });
  });
}
