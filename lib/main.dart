import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OverlayButtonExample(),
    );
  }
}

class OverlayButtonExample extends StatefulWidget {
  @override
  _OverlayButtonExampleState createState() => _OverlayButtonExampleState();
}

class _OverlayButtonExampleState extends State<OverlayButtonExample> {
  bool _showOverlayButton = false;

  void _toggleOverlayButton() {
    setState(() {
      _showOverlayButton = !_showOverlayButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlay Button Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleOverlayButton,
              child: Text('Toggle Overlay Button'),
            ),
          ),
          if (_showOverlayButton)
            Positioned(
              bottom: 50,
              right: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Action for the overlay button
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Overlay Button Pressed'),
                    ),
                  );
                },
                child: Text('Overlay Button'),
              ),
            ),
        ],
      ),
    );
  }
}


// class SoundRecorder extends StatefulWidget {
//   @override
//   _SoundRecorderState createState() => _SoundRecorderState();
// }

// class _SoundRecorderState extends State<SoundRecorder> {
//   FlutterSoundRecorder? _recorder;
//   bool _isRecording = false;
//   String? _filePath;

//   @override
//   void initState() {
//     super.initState();
//     _recorder = FlutterSoundRecorder();
//     _initRecorder();
//   }

//   Future<void> _initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw Exception('Microphone permission not granted');
//     }
//     await _recorder!.openRecorder();
//   }

//   @override
//   void dispose() {
//     _recorder!.closeRecorder();
//     _recorder = null;
//     super.dispose();
//   }

//   Future<void> _startRecording() async {
//     final directory = await getApplicationDocumentsDirectory();
//     _filePath = '${directory.path}/sound_record.aac';
//     await _recorder!.startRecorder(
//       toFile: _filePath,
//       codec: Codec.aacADTS,
//     );
//     setState(() {
//       _isRecording = true;
//     });
//   }

//   Future<void> _stopRecording() async {
//     await _recorder!.stopRecorder();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   Future<void> _playRecording() async {
//     if (_filePath != null) {
//       FlutterSoundPlayer player = FlutterSoundPlayer();
//       await player.openPlayer();
//       await player.startPlayer(fromURI: _filePath, codec: Codec.aacADTS);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sound Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _isRecording ? null : _startRecording,
//               child: Text('Start Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isRecording ? _stopRecording : null,
//               child: Text('Stop Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _playRecording,
//               child: Text('Play Recording'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
