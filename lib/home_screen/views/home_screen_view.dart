import '../home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenView> {
  final _scrollController = ScrollController();

  refreshPage() async {
// You can do run any refresh function here
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () => refreshPage(),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: [
              BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  builder: (context, state) {
                switch (state.status) {
                  case HomeScreenStatus.failure:
                    return const Center(child: Text('Fail'));
                  case HomeScreenStatus.success:
                    {
                      return const Center(child: Text('Success'));
                    }
                  default:
                    return const Center(child: Text('Loading'));
                }
              })
            ]),
          )),
    );
  }

  /// Function ///

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_isBottom) {
      // when the scroll reached bottom, all logic here will run
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
