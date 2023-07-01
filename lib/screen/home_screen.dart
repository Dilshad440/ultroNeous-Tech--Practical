import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultroneous_practical/bloc/user/user_cubit.dart';
import 'package:ultroneous_practical/utils/app_style.dart';
import 'package:ultroneous_practical/utils/constant/global_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<UserCubit>().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _tabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: GlobalConst.tabsScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final totalFavUsers = state.favouriteUsers?.user?.length ?? 0;
        return TabBar(
          indicatorWeight: 3,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelStyle: AppTextStyle.title,
          tabs: GlobalConst.tabsLabel.map((e) => _tabs(e, totalFavUsers)).toList(),
        );
      },
    );
  }

  Tab _tabs(String text, int? totalFavUsers) {
    return Tab(
      icon: text == "Favourite"
          ? Badge(
              label: Text(totalFavUsers.toString()),
            )
          : null,
      text: text,
    );
  }
}
