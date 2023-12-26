// import 'package:animated_emoji/emojis.dart';
import 'package:ai_chat/chat_detail/views/chat_detail_page.dart';
import 'package:ai_chat/new_chat/views/new_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  rive.SMIInput<bool>? _boolExampleInput;
  List prompt = [
    {"title": "Graphic design", "prompt": ""},
    {"title": "UX research", "prompt": ""},
    {"title": "Math solver", "prompt": ""},
    {"title": "Productivity to-do list", "prompt": ""},
    {"title": "Graphic Design", "prompt": ""},
  ];

  List history = [
    {"title": 'Job finder ux', "prompt": ''},
    {"title": 'graphic design copy', "prompt": ''},
    {"title": 'food and beverages', "prompt": ''},
  ];
  List automation = [
    {
      "icon": Icons.shopping_cart,
      "title": 'Today\'s food and beverage shopping',
      "description": 'Based on your morning routine.',
      "prompt": 'Can you plan my weekly shopping list for single person?'
    },
    {
      "icon": Icons.fitness_center_rounded,
      "title": 'Home Workout idea for body shaping',
      "description": 'Based on your morning routine.',
      "prompt": 'Can you plan my workout idea?'
    },
    {
      "icon": Icons.nightlife_outlined,
      "title": 'Romantic gateway for two people',
      "description": 'Based on your selected location.',
      "prompt":
          'Can you plan a romantic gateway for two people at any Southeast Asia island?'
    },
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Chat AI',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
              ),
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
                            'assets/rive/6646-12853-this-is-me-patchpocom.riv',
                            onInit: _onInit,
                          )),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
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
                height: 162,
                padding: const EdgeInsets.only(left: 8),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: automation.length,
                    itemBuilder: (ctx, idx) {
                      return Container(
                        width: 180,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(automation[idx]['icon']),
                            Text('${automation[idx]['title']}'),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(top: 16),
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xff121212),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatDetailPage(
                                                  prompt:
                                                      '${automation[idx]['prompt']}',
                                                )));
                                  },
                                  child: const Text(
                                    'Generate',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending prompt',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  )),
              Wrap(
                spacing: 4,
                children: List.generate(
                  prompt.length,
                  (index) {
                    return Chip(
                      backgroundColor: const Color(0xff121212),
                      side: const BorderSide(color: Colors.transparent),
                      shape: const StadiumBorder(),
                      label: Text(
                        prompt[index]['title'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
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
                        builder: (context) => const NewChatPage(),
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
}
