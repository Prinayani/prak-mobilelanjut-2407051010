import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class AppItem {
  final String nama;
  final IconData ikon;
  final Color warna;
  const AppItem(this.nama, this.ikon, this.warna);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _halaman = 0;

  // Ubah sesuai aplikasi di HP-mu
  static const List<AppItem> _appUtama = [
    AppItem('WhatsApp', Icons.chat, Color(0xFF25D366)),
    AppItem('Musik', Icons.music_note, Color(0xFFFF4D6D)),
    AppItem('YouTube', Icons.play_arrow, Color(0xFFE53935)),
    AppItem('Shopee', Icons.shopping_bag, Color(0xFFEE4D2D)),
  ];

  static const List<AppItem> _appHalaman2 = [
    AppItem('Galeri', Icons.photo, Color(0xFF7E57C2)),
    AppItem('Catatan', Icons.edit_note, Color(0xFFFFA000)),
    AppItem('Maps', Icons.map, Color(0xFF43A047)),
    AppItem('Kalender', Icons.calendar_month, Color(0xFF1E88E5)),
  ];

  static const List<AppItem> _dock = [
    AppItem('', Icons.camera_alt, Color(0xFF424242)),
    AppItem('', Icons.call, Color(0xFF00C853)),
    AppItem('', Icons.settings, Color(0xFF607D8B)),
    AppItem('', Icons.public, Color(0xFFFB8C00)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Wallpaper foto dari folder assets
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Lapisan gelap tipis supaya teks putih terbaca
          color: Colors.black.withOpacity(0.15),
          child: SafeArea(
            child: Column(
              children: [
                _statusBar(),
                Expanded(
                  child: PageView(
                    onPageChanged: (i) => setState(() => _halaman = i),
                    children: [
                      _halamanSatu(),
                      _halamanDua(),
                    ],
                  ),
                ),
                _pageIndicator(),
                const SizedBox(height: 12),
                _dockBawah(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Status bar ----------
  Widget _statusBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Text('13.55',
              style: TextStyle(color: Colors.white, fontSize: 12)),
          Spacer(),
          Icon(Icons.alarm, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Icon(Icons.wifi, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Icon(Icons.signal_cellular_alt, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Icon(Icons.battery_full, color: Colors.white, size: 14),
        ],
      ),
    );
  }

  // ---------- Halaman 1 ----------
  Widget _halamanSatu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            '13.55',
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Text(
            'Minggu, 11 Okt',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 24),
          _searchBar(),
          const Spacer(),
          _barisAplikasi(_appUtama),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ---------- Halaman 2 ----------
  Widget _halamanDua() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          _barisAplikasi(_appHalaman2),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        children: [
          Text(
            'G',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.mic, color: Colors.black54, size: 22),
          SizedBox(width: 12),
          Icon(Icons.center_focus_strong, color: Colors.black54, size: 22),
        ],
      ),
    );
  }

  Widget _barisAplikasi(List<AppItem> daftar) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: daftar.map((a) => _ikonAplikasi(a)).toList(),
    );
  }

  Widget _ikonAplikasi(AppItem app) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: app.warna,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(app.ikon, color: Colors.white, size: 30),
        ),
        if (app.nama.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            app.nama,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ],
    );
  }

  // ---------- Page indicator ----------
  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (i) {
        final aktif = i == _halaman;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: aktif ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: aktif ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  // ---------- Dock / favorite bar ----------
  Widget _dockBawah() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _barisAplikasi(_dock),
    );
  }
}