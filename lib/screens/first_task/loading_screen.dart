import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/classes/json_response_parse.dart';
import 'package:flutter_webspark_test/elements/button.dart';
import 'package:flutter_webspark_test/elements/snack_bar.dart';
import 'package:flutter_webspark_test/functions/send_result_to_server.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  final String url;

  const LoadingScreen({super.key, required this.url});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0;
  bool _isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    _fetchDataWithProgress();
  }

  Future<void> _fetchDataWithProgress() async {
    try {
      final request = http.Request('GET', Uri.parse(widget.url));
      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        String contentType = streamedResponse.headers['content-type'] ?? '';
        //check contentType == json
        if (!contentType.contains('application/json')) {
          throw FormatException('Unexpected content type: $contentType');
        }

        int totalBytes = streamedResponse.contentLength ?? 0;
        int receivedBytes = 0;
        final completer = Completer<void>();
        final List<int> responseData = [];

        streamedResponse.stream.listen(
          (chunk) {
            receivedBytes += chunk.length;
            responseData.addAll(chunk);

            setState(() {
              _progress = (receivedBytes / totalBytes).clamp(0.0, 1.0);
            });
          },
          onDone: () {
            completer.complete();
            try {
              final responseBody = utf8.decode(responseData);
              final paths = JsonResponseParse.processJson(responseBody);
              Provider.of<ProviderState>(
                context,
                listen: false,
              ).setPaths(pths: paths);
              snackBar(context, 'Success get response');
            } catch (e) {
              snackBar(context, 'Error parsing response: $e');
            }
          },
          onError: (error) {
            completer.completeError(error);
            snackBar(context, 'Error $error');
          },
        );

        await completer.future;
      } else {
        snackBar(context, 'Error ${streamedResponse.statusCode}');
        Navigator.pop(context);
      }
    } catch (e) {
      snackBar(context, 'Error $e');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProviderState>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Process screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _progress == 1
                    ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'All calculations has finished, '
                        'you can send your results to server',
                        textAlign: TextAlign.center,
                      ),
                    )
                    : Container(),
                Text(
                  "${(_progress * 100).toStringAsFixed(0)}%",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: _progress,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          _progress == 1
              ? TaskButton(
                textButton: 'Send results to server',
                function: () {
                  _isButtonEnabled
                      ? sendResultToServer(context, appState.paths, widget.url)
                      : null;
                  _isButtonEnabled = false;
                },
              )
              : Container(),
        ],
      ),
    );
  }
}
