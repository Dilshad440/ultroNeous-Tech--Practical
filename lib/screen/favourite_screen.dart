import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultroneous_practical/bloc/user/user_cubit.dart';
import 'package:ultroneous_practical/utils/widgets/empty_users_widget.dart';
import 'package:ultroneous_practical/utils/widgets/user_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final favouriteUser = state.favouriteUsers?.user ?? [];
        if (favouriteUser.isEmpty) {
          return const EmptyUserWidget(
            message: "!!!\nNo users in favourite",
          );
        }
        return ListView.builder(
          itemCount: favouriteUser.length,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (context, index) {
            return UserCard(
              user: favouriteUser[index],
              onTap: () {
                context.read<UserCubit>().removeFromFavorite(favouriteUser[index]);
              },
            );
          },
        );
      },
    ));
  }
}
