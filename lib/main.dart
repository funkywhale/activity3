import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 4, child: _TabsNonScrollableDemo()),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    _textController.dispose();
    super.dispose();
  }

  // Helper method to create image tabs
  Widget _buildImageTab({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              imageUrl,
              width: 150,
              height: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.error, size: 50),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Dog', 'Cat', 'Bird', 'Fish', 'Monkey'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Pet App Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1 - Dog
          _buildImageTab(
            imageUrl:
                'https://i.imgur.com/qpcwgTN_d.webp?maxwidth=520&shape=thumb&fidelity=high',
            title: 'Dog',
            subtitle: 'Bark bark! I am a puppy.',
          ),

          // Tab 2 - Cat
          _buildImageTab(
            imageUrl: 'https://i.imgur.com/6QDK7ki.png',
            title: 'Cat',
            subtitle: 'Meow! I am a cat.',
          ),

          // Tab 3 - Bird
          _buildImageTab(
            imageUrl: 'https://i.imgur.com/t359V95.jpeg',
            title: 'Bird',
            subtitle: 'Tweet tweet! I am a birdy',
          ),

          // Tab 4 - Fish
          _buildImageTab(
            imageUrl: 'https://i.imgur.com/dvvrIwB.jpeg',
            title: 'Fish',
            subtitle: 'Blub blub! I am fish',
          ),

          // Tab 5 - Monkey
          _buildImageTab(
            imageUrl: 'https://i.imgur.com/hTgL4DG_d.webp?maxwidth=520&shape=thumb&fidelity=high',
            title: 'Monkey',
            subtitle: 'Hoo hoo! I am monkey',
          ),
        ],
      ),
    );
  }
}
