import 'package:flutter_tdd_clean_architecture_course/core/utils/string_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStringConverter extends Mock implements StringConverter {}

void main() {
  late MockStringConverter mockStringConverter;
  setUp(() {
    mockStringConverter = MockStringConverter();
  });

  const tNull = null;
  const tNumInString = 10;
  const tNotNumInString = '10a';

  group('string converter test', () {
    test('should return null if string is null', () {
      when(() => mockStringConverter.stringConverter(any())).thenAnswer((_) => tNull);

      int? res = mockStringConverter.stringConverter(tNull);

      expect(res, tNull);
    });

    test('should return int if string is number in string', () {
      when(() => mockStringConverter.stringConverter(any())).thenAnswer((_) => tNumInString);

      int? res = mockStringConverter.stringConverter(tNumInString.toString());

      expect(res, tNumInString);
    });

    test('should return null if string is not number', () {
      when(() => mockStringConverter.stringConverter(any())).thenAnswer((_) => tNull);

      int? res = mockStringConverter.stringConverter(tNotNumInString);

      expect(res, tNull);
    });
  });
}
