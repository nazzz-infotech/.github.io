import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
      ),
      title: "NAZZZ Infotech",
      home: const HomeScreen(),
    );
  }
}

Uri _url = Uri();

Color getRandomColor() {
  Random random = Random();
  final int a = 255;
  int r = random.nextInt(255 - 0 + 1);
  int g = random.nextInt(255 - 0 + 1);
  int b = random.nextInt(255 - 0 + 1);
  return Color.fromARGB(a, r, g, b);
}

class Project {
  final String title;
  final String description;
  final Widget destination;
  final List<Widget> icons;

  Project({
    required this.title,
    required this.description,
    required this.destination,
    required this.icons,
  });
}

final double iconSize = 25.0;

final List<Project> projects = [
  Project(
    title: "Cnotes",
    description:
        "A multiplatform Flutter application for Notes with color and more ...",
    destination: Cnotes(themeColor: getRandomColor()),
    icons: [
      Brand(Brands.flutter, size: iconSize),
      Brand(Brands.dart, size: iconSize),
      Spacer(),
      Brand(Brands.android_os, size: iconSize),
    ],
  ),
  Project(
    title: "Bulk Barcode",
    description:
        "It is cross platform flutter app it can generate barcode in bulk ",
    destination: BulkBarcode(themeColor: getRandomColor()),
    icons: [
      Brand(Brands.flutter, size: iconSize),
      Brand(Brands.dart, size: iconSize),
      Spacer(),
      Brand(Brands.android_os, size: iconSize),
      Brand(Brands.windows_11, size: iconSize),
      Brand(Brands.mac_os_logo, size: iconSize),
      Icon(TeenyIcons.linux, size: iconSize),
    ],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () {
              _url = Uri.parse('https://github.com/nazzz-infotech/');
              _launchUrl();
            },
            icon: const Icon(Bootstrap.github),
            tooltip: "Open NAZZZ-Infotech Github",
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      backgroundColor: colorScheme.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Welcome !",
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = (constraints.maxWidth / 320).floor();
                  crossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount;

                  return Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: projects.map((project) {
                      return SizedBox(
                        width:
                            (constraints.maxWidth -
                                (crossAxisCount - 1) * 16.0) /
                            crossAxisCount,
                        child: Card(
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(project.description),
                                const Divider(),
                                Row(children: project.icons),
                                const Divider(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => project.destination,
                                        ),
                                      );
                                    },
                                    child: const Text("View More"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cnotes extends StatefulWidget {
  final Color themeColor;

  const Cnotes({super.key, required this.themeColor});

  @override
  State<StatefulWidget> createState() => _CnotesPage();
}

class _CnotesPage extends State<Cnotes> {
  final TextEditingController iconLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cnotes",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: widget.themeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cnotes"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            tooltip: "Back",
          ),
          backgroundColor: widget.themeColor,
          foregroundColor: getForegroundColor(
            backgroundColor: widget.themeColor,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Platform Availability"),
                  content: Text(
                    "It is available for android only",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                    SizedBox(width: 5),
                    FilledButton(
                      onPressed: () {
                        _url = Uri.parse(
                          'https://github.com/nazzz-infotech/cnotes/releases',
                        );
                        _launchUrl();
                      },
                      child: Text("Download"),
                    ),
                  ],
                );
              },
            );
          },
          label: Text("Download"),
          icon: Icon(Icons.download),
          tooltip: "Download Cnotes",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cnotes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.0),
              ),
              SizedBox(height: 5),
              Text(
                "A Note App for saving colorful notes with name and content...",
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 6),
              GestureDetector(
                onLongPress: showIconDialog,
                onDoubleTap: showIconDialog,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/icon_cnotes.png'),
                ),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              // Screenshots placeholder
              SizedBox(height: 10),
              Text(
                "Supported Platforms",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [Brand(Brands.android_os, size: 70.0)],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Used programming language & framework",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Brand(Brands.dart, size: 70.0),
                    Brand(Brands.flutter, size: 70.0),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Links & Sources",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 95,
                      width: 300,
                      child: FilledButton(
                        onPressed: () {
                          _url = Uri.parse(
                            'https://github.com/nazzz-infotech/cnotes/',
                          );
                          _launchUrl();
                        },
                        child: Text("Github", style: TextStyle(fontSize: 35.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showIconDialog() {
    iconLink.text =
        "https://github.com/nazzz-infotech/cnotes/blob/master/assets/icon.png";
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Get This Icon"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.0),
            Text("Link of Icon"),
            SizedBox(height: 5.0),
            TextField(readOnly: true, controller: iconLink),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              _url = Uri.parse(iconLink.text);
              _launchUrl();
            },
            child: Text("Open Link"),
          ),
          FilledButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: iconLink.text));
            },
            child: Text("Copy Link"),
          ),
        ],
      ),
    );
  }
}

class BulkBarcode extends StatefulWidget {
  final Color themeColor;

  const BulkBarcode({super.key, required this.themeColor});

  @override
  State<StatefulWidget> createState() => BulkBarcodePage();
}

class BulkBarcodePage extends State<BulkBarcode> {
  final TextEditingController iconLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bulk Barcode",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: widget.themeColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Bulk Barcode"),
          backgroundColor: widget.themeColor,
          foregroundColor: getForegroundColor(
            backgroundColor: widget.themeColor,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Platform Availability"),
                  content: Text(
                    "It is not available for IOS",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                    SizedBox(width: 5),
                    FilledButton(
                      onPressed: () {
                        _url = Uri.parse('https://github.com/nazzz-infotech/bulk_barcode/releases');
                        _launchUrl();
                      },
                      child: Text("Download"),
                    ),
                  ],
                );
              },
            );
          },
          label: Text("Download"),
          icon: Icon(Icons.download),
          tooltip: "Bulk Barcode",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bulk Barcode",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.0),
              ),
              SizedBox(height: 5),
              Text(
                "It is cross platform flutter app it can generate barcode in bulk by enter data manually or import data form excel file then select separator . It can export Barcode / QR to a excel file with [ Index | Input Data | Barcode / QR Image ] and print / save pdf",
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 5),
              GestureDetector(
                onLongPress: showIconDialog,
                onDoubleTap: showIconDialog,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: NetworkImage(
                      'https://raw.githubusercontent.com/nazzz-infotech/bulk_barcode/refs/heads/master/assets/icon.png',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Some Screenshot of App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 1000),
                child: ListView(
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/nazzz-infotech/bulk_barcode/refs/heads/master/image.png',
                      ),
                    ),
                    SizedBox(height: 3.5),
                    Container(height: 10, color: Colors.blueGrey),
                    SizedBox(height: 3.5),
                    Image(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/nazzz-infotech/bulk_barcode/refs/heads/master/Screenshot_2025-06-20-21-16-11-232_com.example.bulk_barcode.jpg',
                      ),
                    ),
                    SizedBox(height: 3.5),
                    Container(height: 10, color: Colors.blueGrey),
                    SizedBox(height: 3.5),
                    Image(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/nazzz-infotech/bulk_barcode/refs/heads/master/Screen%20Recording%202025-06-20%20212655.gif',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              // Screenshots placeholder
              SizedBox(height: 10),
              Text(
                "Supported Platforms",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Brand(Brands.android_os, size: 70.0),
                    Brand(Brands.windows_11, size: 70.0),
                    Brand(Brands.mac_os_logo, size: 70.0),
                    Icon(TeenyIcons.linux, size: 70.0),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Used programming language & framework",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Brand(Brands.dart, size: 70.0),
                    Brand(Brands.flutter, size: 70.0),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Links & Sources",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
              SizedBox(height: 5),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 95,
                      width: 300,
                      child: FilledButton(
                        onPressed: () {
                          _url = Uri.parse('https://github.com/nazzz-infotech/bulk_barcode/');
                          _launchUrl();
                        },
                        child: Text("Github", style: TextStyle(fontSize: 35.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showIconDialog() {
    iconLink.text =
        "https://github.com/nazzz-infotech/bulk_barcode/blob/master/assets/icon.png";
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Get This Icon"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.0),
            Text("Link of Icon"),
            SizedBox(height: 5.0),
            TextField(readOnly: true, controller: iconLink),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              _url = Uri.parse(iconLink.text);
              _launchUrl();
            },
            child: Text("Open Link"),
          ),
          FilledButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: iconLink.text));
            },
            child: Text("Copy Link"),
          ),
        ],
      ),
    );
  }
}

bool useWhiteForeground(Color backgroundColor) {
  return backgroundColor.computeLuminance() <= 0.4;
}

Color getForegroundColor({required Color backgroundColor}) {
  if (useWhiteForeground(backgroundColor)) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
