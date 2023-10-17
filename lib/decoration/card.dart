import "package:flutter/material.dart";
import "dart:ui";

class Cards extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const Cards({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            color: Color.fromARGB(35, 255, 255, 255),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontSize: 20, color: Colors.white54),
                      ),
                      Divider(
                        color: Colors.white70,
                      ),
                      SizedBox(height: 5),
                      Icon(
                        icon,
                        color: Colors.white54,
                        size: 60,
                      ),
                      SizedBox(height: 7),
                      Text(
                        '$temperature°C',
                        style: TextStyle(fontSize: 20, color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
