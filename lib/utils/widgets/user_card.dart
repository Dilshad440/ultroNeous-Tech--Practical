import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultroneous_practical/bloc/user/user_cubit.dart';
import 'package:ultroneous_practical/model/response/user_response.dart';
import 'package:ultroneous_practical/utils/app_style.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fav =
        context.select((UserCubit cubit) => cubit.state.favouriteUsers?.user?.contains(user) ?? false);
    final color = fav ? Colors.red : Colors.blue;
    return Card(
      elevation: 5,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text(text: "FirstName"),
                    _text(text: "Last Name"),
                    _text(text: "Email"),
                    _text(text: "Address"),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _text(text: user.name?.first ?? ""),
                      _text(text: user.name?.last ?? ""),
                      _text(text: user.email ?? ""),
                      _text(text: user.location?.street?.name ?? ""),
                    ],
                  ),
                )
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: onTap,
            icon: Icon(
              Icons.favorite,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Text _text({required String text}) => Text(
        text,
        style: AppTextStyle.title,
      );
}
