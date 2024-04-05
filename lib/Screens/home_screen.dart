import 'package:face_recogniization/Screens/camera_page.dart';
import 'package:face_recogniization/Screens/profile_page.dart';
import 'package:face_recogniization/Screens/image_display_screen.dart';
import 'package:face_recogniization/Screens/video_page.dart';
import 'package:face_recogniization/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'demo_vidiopage.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
        'assets/facevideo1.mp4'); // Replace with your video filename
    _controller.addListener(() => setState(() {}));
    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Face Detection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8A2387),
                Color(0xFFE94057),
                Color(0xFFF27121),
              ],
            ),
          ),
        ),
        shadowColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile page or handle profile action
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        //backgroundColor: Colors.grey,
        shadowColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A2387),
                    Color(0xFFE94057),
                    Color(0xFFF27121),
                  ],
                ),
              ),
              child: const Text(
                'Face Detection App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                // Handle camera action
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CameraPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              onTap: () {
                // Handle theme change action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                // Handle history action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.feedback_outlined),
              title: const Text('Feedback'),
              onTap: () {
                // Handle notification settings action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help'),
              onTap: () {
                // Handle help and feedback action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Privacy Policy'),
              onTap: () {
                // Handle privacy policy action
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text('Logout'),
              onTap: () {
                // Perform logout validation
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform logout
                            FirebaseAuth.instance.signOut();
                            // Navigate to the sign-in screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Videos",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('For Understanding Face Detection Videos'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final videoData in [
                        {
                          'url': 'assets/facevideo1.mp4',
                          'thumbnail': 'assets/thumb1.jpeg'
                        },
                        {
                          'url': 'assets/facevideo2.mp4',
                          'thumbnail': 'assets/thumb2.jpeg'
                        },
                        // Add more video URLs and thumbnails here
                      ])
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoPage(videoUrl: videoData['url'] ?? ''),
                              ),
                            );
                            child:
                            Icon(Icons.arrow_forward_ios);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            width: 200,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                              image: DecorationImage(
                                image: AssetImage(videoData['thumbnail'] ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),

                //https://youtu.be/xFXGlMpgXOk?si=RhieF6aW2ku3KiTq
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final videoData in [
                        {
                          'url':
                              'https://www.youtube.com/watch?v=_a6DcgkEZcM&pp=ygUFc29uZ3M%3D',
                          'thumbnail':
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsW8ZsU941R0tTmAuleI0b2GHavTawfuh-eQ&usqp=CAU'
                        },
                        {
                          'url':
                              'https://youtu.be/xFXGlMpgXOk?si=RhieF6aW2ku3KiTq',
                          'thumbnail':
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsW8ZsU941R0tTmAuleI0b2GHavTawfuh-eQ&usqp=CAU'
                        },
                        // Add more YouTube video URLs and thumbnails here
                      ])
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerPage(
                                  videoUrl: videoData['url'] ?? '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            width: 200,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  videoData['thumbnail'] ?? '',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Icon(Icons.play_circle_fill,
                                    size: 50, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  "Images",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('See Face Detection in Action'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 8.0,
                    children: [
                      for (final imageAsset in [
                        // List of your image asset paths
                        'assets/criminal10.png',
                        'assets/criminal11.jpg',
                        // Add more image asset paths here
                      ])
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          child: Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 8.0,
                    children: [
                      for (final imageAsset in [
                        // List of your image asset paths
                        'assets/face3.jpeg',
                        'assets/face4.jpeg',
                        // Add more image asset paths here
                      ])
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          child: Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80,
              width: 320,
              //backgroundColor: Colors.transparent,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A2387),
                    Color(0xFFE94057),
                    Color(0xFFF27121),
                  ],
                ),
              ),

              //color: Colors.red, // Set footer background color
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MediaDisplayPage(imagePath: image.path),
                          ),
                        );
                      } else {
                        final XFile? video = await _picker.pickVideo(
                            source: ImageSource.gallery);
                        if (video != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerWidget(videoPath: video.path),
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.upload),
                    label: Text(
                      'Upload',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle camera action
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraPage()));
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text(
                      'Camera',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerPage extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
