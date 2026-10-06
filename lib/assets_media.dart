import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class AssetsMediaPage extends StatefulWidget {
  const AssetsMediaPage({super.key});

  @override
  State<AssetsMediaPage> createState() => _AssetsMediaPageState();
}

class _AssetsMediaPageState extends State<AssetsMediaPage> {
  // ===== AUDIO =====
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  // ===== VIDEO (nilai tambahan) =====
  late VideoPlayerController videoController;
  bool videoError = false;

  @override
  void initState() {
    super.initState();

    // Saat audio selesai, tombol kembali jadi Play
    player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => isPlaying = false);
    });

    videoController = VideoPlayerController.asset('assets/videos/video.mp4');
    videoController.initialize().then((_) {
      if (mounted) setState(() {});
    }).catchError((_) {
      if (mounted) setState(() => videoError = true);
    });
  }

  Future<void> playAudio() async {
    if (isPlaying) {
      await player.pause();
    } else {
      if (player.state == PlayerState.paused) {
        await player.resume();
      } else {
        await player.play(AssetSource('audios/music.mp3'));
      }
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void toggleVideo() {
    setState(() {
      if (videoController.value.isPlaying) {
        videoController.pause();
      } else {
        videoController.play();
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ===== PROFILE =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5FB),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpeg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Neti', // <-- ganti dengan nama lengkapmu
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== AUDIO =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Audio Motivasi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E5FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: const Color(0xFF4D63D9),
                            child: IconButton(
                              onPressed: playAudio,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              backgroundColor: Color(0xFFC8CDEF),
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xFF4D63D9),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.volume_up,
                            color: Color(0xFF202342),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===== VIDEO (nilai tambahan) =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5FB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Video',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (videoError)
                      const Text('Video tidak ditemukan / gagal dimuat')
                    else if (videoController.value.isInitialized)
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: VideoPlayer(videoController),
                            ),
                          ),
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: toggleVideo,
                            iconSize: 44,
                            color: const Color(0xFF4D63D9),
                            icon: Icon(
                              videoController.value.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                            ),
                          ),
                        ],
                      )
                    else
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}