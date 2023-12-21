// import 'package:animated_emoji/emojis.dart';
import 'package:ai_chat/chat_detail/views/chat_detail_page.dart';
import 'package:ai_chat/new_chat/views/new_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Chat AI',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Automation',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: automation.length,
                  itemBuilder: (ctx, idx) {
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(automation[idx]['icon']),
                          Text('${automation[idx]['title']}'),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatDetailPage(
                                            prompt:
                                                '${automation[idx]['prompt']}',
                                          )));
                                },
                                child: const Text('Generate')),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        // padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NewChatPage(),
                      ),
                    );
                  },
                  child: const Text('+ New Chat')),
            )
          ],
        ),
      ),
    );
  }
}
