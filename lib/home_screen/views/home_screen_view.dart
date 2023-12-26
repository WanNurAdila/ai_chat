import 'dart:convert';

import 'package:ai_chat/chat_detail/views/chat_detail_page.dart';
import 'package:ai_chat/home_screen/bloc/trending_prompt/trending_prompt_bloc.dart';
import 'package:ai_chat/new_chat/views/new_chat_page.dart';
import 'package:flutter/services.dart';

import '../home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenView> {
  rive.SMIInput<bool>? _boolExampleInput;

  List history = [
    {"title": 'Job finder ux', "prompt": ''},
    {"title": 'graphic design copy', "prompt": ''},
    {"title": 'food and beverages', "prompt": ''},
  ];

  void _onInit(rive.Artboard art) {
    var controller =
        rive.StateMachineController.fromArtboard(art, 'State Machine 1');
    art.addController(controller!);
    _boolExampleInput = controller.findInput<bool>('Boolean 1') as rive.SMIBool;
    _boolExampleInput?.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff2d2026), Color(0xff1d1e54)],
              stops: [0.25, 0.75],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 40,),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 235,
                        child: const Text(
                          'Good Morning, Jane',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          child: rive.RiveAnimation.asset(
                            'assets/rive/avatar.riv',
                            onInit: _onInit,
                          )),
                    ]),
              ),
              BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  builder: (context, state) {
                switch (state.status) {
                  case HomeScreenStatus.failure:
                    return const Center(child: Text('Fail'));
                  case HomeScreenStatus.success:
                    {
                      final withoutchara =
                          state.result.replaceAll(RegExp('`'), '');
                      final withoutjson =
                          withoutchara.replaceAll(RegExp('json'), '');

                      final automation = jsonDecode(withoutjson);

                      return Column(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 16, bottom: 16),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Automation',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            height: 250,
                            padding: const EdgeInsets.only(left: 8),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: automation.length,
                                itemBuilder: (ctx, idx) {
                                  return Container(
                                    width: 180,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${automation[idx]['short_title']}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                '${automation[idx]['description']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff121212),
                                                side: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewChatPage(
                                                      title:
                                                          '${automation[idx]['short_title']}',
                                                      prompt:
                                                          '${automation[idx]['prompt']}',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Generate',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }
                  default:
                    return const Center(child: Text('Loading'));
                }
              }),
              BlocBuilder<TrendingPromptBloc, TrendingPromptState>(
                  builder: (context, state) {
                switch (state.status) {
                  case TrendingPromptStatus.failure:
                    return const Center(child: Text('Fail'));
                  case TrendingPromptStatus.success:
                    {
                      final withoutchara =
                          state.result.replaceAll(RegExp('`'), '');
                      final withoutjson =
                          withoutchara.replaceAll(RegExp('json'), '');

                      final prompt = jsonDecode(withoutjson);

                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Trending prompt',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              spacing: 4,
                              children: List.generate(
                                prompt.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NewChatPage(
                                            title:
                                                '${prompt[index]['keyword']}',
                                            prompt:
                                                '${prompt[index]['prompt']}',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Chip(
                                      backgroundColor: const Color(0xff121212),
                                      side: const BorderSide(
                                          color: Colors.transparent),
                                      shape: const StadiumBorder(),
                                      label: Text(
                                        prompt[index]['keyword'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  default:
                    return const Center(child: Text('Loading'));
                }
              }),
            ]),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  onPressed: () {
                    _boolExampleInput?.value = true;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewChatPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '+ New Chat',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }

  /// Function ///
}
