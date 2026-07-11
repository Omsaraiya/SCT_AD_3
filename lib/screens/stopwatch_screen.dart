import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _pauseTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {});
  }

  String _formattedTime() {
    int milli = _stopwatch.elapsedMilliseconds;
    String minutes = ((milli ~/ 60000) % 60).toString().padLeft(2, '0');
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, '0');
    String milliseconds = ((milli % 1000) ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- TIME DISPLAY (Neon Circle Design) ---
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(0.5),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.1),
                    blurRadius: 50,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Text(
                _formattedTime(),
                style: const TextStyle(
                  fontSize: 54, // Bada aur clear font
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),

            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularButton(
                  label: 'Reset',
                  icon: Icons.refresh,
                  color: Colors.white54,
                  onTap: _resetTimer,
                ),

                _buildCircularButton(
                  label: _stopwatch.isRunning ? 'Pause' : 'Start',
                  icon: _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                  color: _stopwatch.isRunning
                      ? Colors.orangeAccent
                      : Colors.greenAccent,
                  onTap: _stopwatch.isRunning ? _pauseTimer : _startTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1), // Halka transparent background
              border: Border.all(color: color, width: 2), // Solid border
            ),
            child: Icon(icon, color: color, size: 35), // Bada icon
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
