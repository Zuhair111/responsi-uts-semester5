import 'package:flutter/material.dart';
import 'search_page.dart';
import 'story_view_page.dart';
import 'reels_page.dart';
import 'notifications_page.dart';
import 'comments_page.dart';
import 'create_post_page.dart';
import 'chat_list_page.dart';
import 'profile_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Map<String, String>> stories = [
    {'name': 'Your Story', 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
    {'name': 'Emilia', 'image': 'https://randomuser.me/api/portraits/women/2.jpg'},
    {'name': 'Richard', 'image': 'https://randomuser.me/api/portraits/men/3.jpg'},
    {'name': 'Jasmine', 'image': 'https://randomuser.me/api/portraits/women/4.jpg'},
  ];

  List<bool> liked = [false, false];
  List<int> likeCount = [221, 178];

// Method untuk memilih halaman berdasarkan selectedIndex
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return SearchPage();
      case 2:
        return ChatListPage();
      case 3:
        return ProfilePage(); // Tambahkan ini
      default:
        return _buildHomePage();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _getSelectedPage(), // Ganti di sini
      endDrawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: _selectedIndex == 0 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.search,
                    color: _selectedIndex == 1 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline,
                    color: _selectedIndex == 2 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2; // Ubah hanya setState, tidak push
                  });
                },
              ),
              IconButton( // Update dari Icon menjadi IconButton
                icon: Icon(Icons.person_outline,
                    color: _selectedIndex == 3 ? Colors.orange : Colors.grey),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  

  Widget _buildHomePage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Home",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          backgroundColor: Colors.white,
          elevation: 0,
          floating: true,
          pinned: false,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.video_collection_outlined, color: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReelsPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.grid_view, color: Colors.orange),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizedBox(width: 10),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildStoriesSection(),
              _buildPostCard(
                index: 0,
                userName: 'Lucas Mokmana',
                location: 'Bangkok, Thailand',
                timeAgo: '2m ago',
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do sum sit emat 😎😎',
                imageUrl: 'https://picsum.photos/400/600?random=1',
                likes: likeCount[0],
                comments: '150',
              ),
              _buildPostCard(
                index: 1,
                userName: 'Hendri Lee',
                location: 'Shibuya, Japan',
                timeAgo: '2m ago',
                text: 'Menikmati sore hari di kota Tokyo ✨',
                imageUrl: 'https://picsum.photos/400/600?random=2',
                likes: likeCount[1],
                comments: '80',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStoriesSection() {
    return Container(
      height: 110,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryViewPage(
                    stories: stories,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Container(
              width: 70,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(stories[index]['image']!),
                      ),
                      if (index == 1)
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Live',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stories[index]['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostCard({
    required int index,
    required String userName,
    required String location,
    required String timeAgo,
    required String text,
    required String imageUrl,
    required int likes,
    required String comments,
  }) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://randomuser.me/api/portraits/men/9.jpg'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      Text('$location • $timeAgo',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _showShareBottomSheet(context);
                },
                child: Icon(Icons.share, color: Colors.orange),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(text, style: TextStyle(fontSize: 13)),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    liked[index] = !liked[index];
                    liked[index] ? likeCount[index]++ : likeCount[index]--;
                  });
                },
                child: Icon(
                  liked[index] ? Icons.favorite : Icons.favorite_border,
                  color: liked[index] ? Colors.red : Colors.grey,
                ),
              ),
              SizedBox(width: 5),
              Text(likeCount[index].toString()),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentsPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.purple),
                    SizedBox(width: 5),
                    Text(comments),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: 280,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(25)),
      ),
      child: Container(
        color: Color(0xFFFFA36C),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(color: Color(0xFFFFA36C)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/2.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text("Good Morning",
                      style: TextStyle(color: Colors.white70)),
                  Text("Emilia",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MAIN MENU",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  _drawerItem(Icons.favorite, "Welcome"),
                  _drawerItem(Icons.home, "Home"),
                  _drawerItem(Icons.layers, "Pages"),
                  _drawerItem(Icons.widgets_outlined, "Components"),
                  _drawerItem(Icons.notifications, "Notification", badge: 1),
                  _drawerItem(Icons.person_outline, "Profile"),
                  _drawerItem(Icons.chat, "Chat", badge: 5),
                  _drawerItem(Icons.logout, "Logout"),
                  Divider(color: Colors.white70),
                  SizedBox(height: 10),
                  Text("SETTINGS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  _drawerItem(Icons.color_lens_outlined, "Color Theme"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.nightlight_round, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Dark Mode",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Switch(value: false, onChanged: (_) {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {int? badge}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: badge != null
          ? Container(
              padding: EdgeInsets.all(6),
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Text('$badge',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            )
          : null,
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    final List<Map<String, String>> users = [
      {
        'name': 'Andy Lee',
        'username': 'mr_andy_lee',
        'image': 'https://randomuser.me/api/portraits/women/10.jpg'
      },
      {
        'name': 'Brian Harahap',
        'username': 'brian_harahap',
        'image': 'https://randomuser.me/api/portraits/men/11.jpg'
      },
      {
        'name': 'Christian Hang',
        'username': 'christian_Hang',
        'image': 'https://randomuser.me/api/portraits/men/12.jpg'
      },
      {
        'name': 'Chloe Mc. Jenskin',
        'username': 'chloe_mc_jenskin',
        'image': 'https://randomuser.me/api/portraits/women/13.jpg'
      },
      {
        'name': 'David Bekam',
        'username': 'david_bekam',
        'image': 'https://randomuser.me/api/portraits/men/14.jpg'
      },
      {
        'name': 'Donas High',
        'username': 'donas_high',
        'image': 'https://randomuser.me/api/portraits/men/15.jpg'
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Write a message ...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search..',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(users[index]['image']!),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  users[index]['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  users[index]['username']!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Shared to ${users[index]['name']}'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}