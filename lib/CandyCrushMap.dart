import 'package:flutter/material.dart';

class CandyCrushMap extends StatelessWidget {
  const CandyCrushMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer( // pinch zoom and pan optional
        minScale: 1,
        maxScale: 1,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background map
              Image.asset(
                "assets/images/bg1.png",
                fit: BoxFit.fitWidth,
                height: 4100, // long map
                width: MediaQuery.of(context).size.width,
              ),

              // Levels positioned on the path
              Positioned(
                top: 4000,
                left: 200,
                child: LevelNode(title: "البقرة", stars: 2, completed: true),
              ),
              Positioned(
                top: 400,
                right: 450,
                child: LevelNode(title: "آل عمران", stars: 1, completed: true),
              ),
              Positioned(
                top: 600,
                left: 160,
                child: LevelNode(title: "النساء", stars: 1, completed: false),
              ),
              Positioned(
                top: 800,
                right: 150,
                child: LevelNode(title: "المائدة", stars: 0, completed: false),
              ),
              // Add more...
            ],
          ),
        ),
      ),
    );
  }
}

class LevelNode extends StatelessWidget {
  final String title;
  final int stars;
  final bool completed;

  const LevelNode({
    super.key,
    required this.title,
    required this.stars,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped $title");
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.purpleAccent,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              if (completed)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.check_circle, color: Colors.cyan, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: index < stars ? Colors.yellow : Colors.white,
                size: 16,
              );
            }),
          ),
        ],
      ),
    );
  }
}