import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
const String APIURL = 'https://apisolarium20230219114929.azurewebsites.net/solarium';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}

final photos = [
  'https://images.pexels.com/photos/13138032/pexels-photo-13138032.jpeg',
  'https://images.pexels.com/photos/12027822/pexels-photo-12027822.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/5092885/pexels-photo-5092885.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/1321290/pexels-photo-1321290.jpeg?auto=compress&cs=tinysrgb&w=400',
  'https://images.pexels.com/photos/6923735/pexels-photo-6923735.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/611328/pexels-photo-611328.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=400&h=250&fit=crop&crop=focalpoint',
  'https://images.pexels.com/photos/886109/pexels-photo-886109.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=400&h=250&fit=crop&crop=focalpoint',
  'https://images.pexels.com/photos/852793/pexels-photo-852793.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=400&h=250&fit=crop&crop=focalpoint',
  'https://media.istockphoto.com/id/1145171942/photo/time-concept-bunch-of-watches-3d-render.jpg?b=1&s=612x612&w=0&k=20&c=FsmBvx8Bub_3XMjvrgqWsf2NMkPPQbtWVy_Rc-hrYkg=',
  'https://images.pexels.com/photos/870711/pexels-photo-870711.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/3907574/pexels-photo-3907574.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/46148/aircraft-jet-landing-cloud-46148.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/2894955/pexels-photo-2894955.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/9676577/pexels-photo-9676577.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/143580/pexels-photo-143580.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/2623878/pexels-photo-2623878.jpeg?auto=compress&cs=tinysrgb&w=600',
  'https://images.pexels.com/photos/127160/pexels-photo-127160.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/3830752/pexels-photo-3830752.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/3748174/pexels-photo-3748174.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/114974/pexels-photo-114974.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/2337789/pexels-photo-2337789.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/267559/pexels-photo-267559.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/2781540/pexels-photo-2781540.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/769525/pexels-photo-769525.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/935835/pexels-photo-935835.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/13419253/pexels-photo-13419253.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/3905693/pexels-photo-3905693.jpeg?auto=compress&cs=tinysrgb&w=1600'
];

class ParticipantPage extends StatefulWidget {
  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage>
    with SingleTickerProviderStateMixin {
  var trayItems = [-1, -1, -1];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    print("Init State called");
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    print("dispose called");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PhotoGrid(photos: photos, callback: addToTray),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.background,
        child: SizedBox(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < trayItems.length; i++)
                if (trayItems[i] != -1)
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return GestureDetector(
                        onLongPress: () {
                          http.put(Uri.parse(APIURL + "?imageURL=" + photos[trayItems[i]]));
                        },
                        onDoubleTap: () {
                          print("APPBAR: double tap");
                        },
                        onTap: () {
                          print("TAP: removing");
                          removeFromTray(i);
                        },
                        child: Container(
                          width: 100, //need fixing
                          height:
                              100 / 100 * _animation.value, // need much fixing
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(photos[trayItems[i]]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Placeholder(
                    fallbackWidth: 100,
                    fallbackHeight: 100,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void removeFromTray(int i) {
    return setState(() {
      trayItems[i] = -1;
    });
  }

  void addToTray(int value) {
    setState(() {
      //check if image already exist
      if (trayItems.contains(value)) {
        return;
      }

      //find the first empty tray item
      for (var i = 0; i < trayItems.length; i++) {
        if (trayItems[i] == -1) {
          trayItems[i] = value;
          print("addToTray $i");
          break;
        }
      }
      _controller.reset();
      _controller.forward();
    });
  }
}

class PhotoGrid extends StatefulWidget {
  final List<String> photos;
  final Function callback;
  PhotoGrid({required this.photos, required this.callback});

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  //var selectedItem = -1;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.photos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onLongPress: () {
            print("long press");
            setState(() {
              widget.callback(index);
            });
          },
          onTap: () {
            print("on tap: $index");
            // Handle tap on photo tile
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.photos[index]),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(fixedSize: Size(200, 60));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ParticipantPage()),
                );
              },
              child: Text('참여자 / Participant'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PresenterPage()),
                );
              },
              child: Text('Image Board'),
            ),
          ],
        ),
      ),
    );
  }
}

class PresenterPage extends StatefulWidget {
  @override
  State<PresenterPage> createState() => _PresenterPageState();
}

class _PresenterPageState extends State<PresenterPage> {
  String _imageUrl =
      'https://images.pexels.com/photos/326576/pexels-photo-326576.jpeg?auto=compress&cs=tinysrgb&w=600';
  late Future<String> imgUrl;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      print("Fetching data");
      final response =
          await http.get(Uri.parse(APIURL));
      if (response.statusCode == 200) {
        //final jsonData = json.decode(response.body);
        print(response);
        _imageUrl = response.body;
        setState(() {});
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 5))
        .asyncMap((event) => fetchData()),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }
    );
  }
}
