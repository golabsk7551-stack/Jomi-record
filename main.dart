import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const LandRecordApp());
}

class LandRecordApp extends StatelessWidget {
  const LandRecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ভূমির দলিল ও অংশ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const RecordViewerScreen(),
    const ShareCalculatorScreen(),
    const MapViewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.business, color: Colors.teal),
            ),
            const SizedBox(width: 10),
            const Text(
              'জমি ও রেকর্ড',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'রেকর্ড',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'হিসাব',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'ম্যাপ',
          ),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class RecordViewerScreen extends StatefulWidget {
  const RecordViewerScreen({super.key});

  @override
  State<RecordViewerScreen> createState() => _RecordViewerScreenState();
}

class _RecordViewerScreenState extends State<RecordViewerScreen> {
  InAppWebViewController? webViewController;
  final String banglarBhumiUrl = "https://banglarbhumi.gov.in/BanglarBhumi/KnowYourProperty";

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(banglarBhumiUrl)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
    );
  } // বাকি কোড একই থাকবে, যা আগে দেওয়া হয়েছিল
}
