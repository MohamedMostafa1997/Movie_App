import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ConnectionError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.redAccent),
          SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon:  Icon(Icons.refresh),
            label:  Text("Refresh"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              backgroundColor: Colors.white,
              padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}
