import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String _response = 'Here we will display response...';

  Future<void> _getResponse(String question) async {
    final url = Uri.parse(
        //For text Moderation Test
        // 'https://api.turboline.ai/openai/moderations'

        // For answering Question

        //For Chat Completion
        'https://api.turboline.ai/openai/chat/completions');

    final headers = {
      //Moderation Test
      "Content-Type": "application/json",
      "X-TL-Key": "a3f48783e2834526a4eff8056abce4b7",

      //Chat Completion
    };

    final body = jsonEncode({
      //Moderation Test
      // "input": question,
      // "model": "text-moderation-latest"

      //Chat Completion
      "model": "gpt-3.5-turbo",
      'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {
          'role': 'user',
          'content': 'which disease has these symptoms $question'
        }
      ],
      'temperature': 0.7,
      'max_tokens': 100
    });

    print('Creating Response');

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Response Created');
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        //---------------------------------------------
        // Moderation Test
        //---------------------------------------------
        // final results = data['results'] as List<dynamic>;
        // List<String> flaggedCategories = [];
        // for (var result in results) {
        //   final categories = result['categories'] as Map<String, dynamic>;
        //   categories.forEach((category, isFlagged) {
        //     if (isFlagged) {
        //       flaggedCategories.add(category);
        //     }
        //   });
        // }
        // setState(() {
        //   _response = flaggedCategories.isNotEmpty
        //       ? 'Flagged Categories: ${flaggedCategories.join(', ')}'
        //       : 'No flagged categories.';
        // });

        //----------------------------------------
        //Chat Completion
        //----------------------------------------

        final result = data['choices'][0]['message']['content'];
        setState(() {
          _response = result.toString();
        });
      } else {
        setState(() {
          _response = 'Failed to get an answer';
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LifeScribe',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  labelText: 'Ask Something', border: InputBorder.none),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print("Button clicked ");
                  _getResponse(_controller.text);
                },
                child: Text('Ask')),
            SizedBox(
              height: 20,
            ),
            Text(
              _response,
              // 'Here we will display response...',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
