import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ultroneous_practical/bloc/user/user_cubit.dart';
import 'package:ultroneous_practical/model/mapper_response/user_model.dart';
import 'package:ultroneous_practical/model/res_invalid_model.dart';
import 'package:ultroneous_practical/model/response/user_response.dart';
import 'package:ultroneous_practical/utils/constant/global_constant.dart';
import 'package:ultroneous_practical/utils/widgets/user_card.dart';

import 'mock_cubit/user_mock_cubit.dart';

void main() {
  testWidgets('renders user details correctly', (WidgetTester tester) async {
    User user = User(
      name: Name(first: 'John', last: 'Doe'),
      email: 'johndoe@example.com',
      location: Location(street: Street(name: '123 Main St')),
    );

    await tester.pumpWidget(UserCard(user: user, onTap: () {}));

    expect(find.text('FirstName'), findsOneWidget);
    expect(find.text('LastName'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('test'), findsOneWidget);
    expect(find.text('user'), findsOneWidget);
    expect(find.text('user@gmail.com'), findsOneWidget);
    expect(find.text('Ahmedabad'), findsOneWidget);
  });

  group('UserCubit', () {
    late UserCubit userCubit;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      userCubit = UserCubit();
    });

    tearDown(() {
      userCubit.close();
    });

    test('fetchUser emits loaded state when successful', () {
      // Arrange
      final users = [User(name: Name(first: "ABC", last: "XYZ", title: "Mr"))];
      final model = UserModel(user: users);
      when(userRepository.fetchUsers(page: 1)).thenAnswer((_) => Future.value(model));

      // Assert later
      expectLater(
        userCubit,
        emitsInOrder([
          const UserState(apiState: ApiState.loading),
          UserState(apiState: ApiState.loaded, users: model),
        ]),
      );

      // Act
      userCubit.fetchUser();
    });

    test('fetchUser emits error state when an error occurs', () {
      // Arrange
      final error = ResInvalidBaseModel(statusCode: 500, message: 'Internal Server Error');
      when(userRepository.fetchUsers(page: 1)).thenThrow(error);

      // Assert later
      expectLater(
        userCubit,
        emitsInOrder([
          const UserState(apiState: ApiState.loading),
          const UserState(apiState: ApiState.error),
        ]),
      );

      // Act
      userCubit.fetchUser();
    });
  });
}
