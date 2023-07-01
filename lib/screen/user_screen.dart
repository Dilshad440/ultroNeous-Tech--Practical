import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultroneous_practical/bloc/user/user_cubit.dart';
import 'package:ultroneous_practical/utils/constant/global_constant.dart';
import 'package:ultroneous_practical/utils/widgets/error_screen.dart';
import 'package:ultroneous_practical/utils/widgets/loding_widget.dart';
import 'package:ultroneous_practical/utils/widgets/user_card.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter <= 0) {
        context.read<UserCubit>().fetchMoreUsers();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.apiState == ApiState.loading) {
            return const LoadingWidget();
          }
          if (state.apiState == ApiState.error) {
            return ErrorScreen(
              error: state.error?.message ?? "Oops!!\nSomething Went Wrong",
            );
          }
          final users = state.users?.user ?? [];
          final isLoadingMore = state.loadingMore;
          return ListView.builder(
            controller: _scrollController,
            itemCount: users.length + (isLoadingMore ? 1 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemBuilder: (context, index) {
              if (index < users.length) {
                return Column(
                  children: [
                    UserCard(
                      user: users[index],
                      onTap: () {
                        context.read<UserCubit>().addUserToFavourite(users[index]);
                      },
                    ),
                  ],
                );
              } else if (isLoadingMore) {
                return const LoadingWidget();
              } else {
                return Container(); // Empty container if not loading more
              }
            },
          );
        },
      ),
    );
  }
}
