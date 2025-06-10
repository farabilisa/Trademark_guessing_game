import 'package:flutter/material.dart';

void main() {
  runApp(const TrademarkGuessingGame());
}

class TrademarkGuessingGame extends StatelessWidget {
  const TrademarkGuessingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trademark Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Trademark {
  final String imagePath;
  final String answer;

  Trademark({required this.imagePath, required this.answer});
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Trademark> trademarks = [
    Trademark(imagePath: 'assets/apple.png', answer: 'apple'),
    Trademark(imagePath: 'assets/google.png', answer: 'google'),
    Trademark(imagePath: 'assets/nike.png', answer: 'nike'),
    Trademark(imagePath: 'assets/starbucks.png', answer: 'starbucks'),
    Trademark(imagePath: 'assets/mcdonalds.png', answer: 'mcdonalds'),
  ];

  int currentIndex = 0;
  int score = 0;
  String userInput = '';
  String message = '';

  void checkAnswer() {
    if (userInput.trim().toLowerCase() == trademarks[currentIndex].answer) {
      setState(() {
        score++;
        message = 'Correct! 🎉';
      });
      Future.delayed(const Duration(seconds: 1), nextTrademark);
    } else {
      setState(() {
        message = 'Incorrect. Try again!';
      });
    }
  }

  void nextTrademark() {
    setState(() {
      if (currentIndex < trademarks.length - 1) {
        currentIndex++;
        userInput = '';
        message = '';
      } else {
        message = 'Game Over! Your score: $score/${trademarks.length}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isGameOver = currentIndex >= trademarks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trademark Name Guessing Game'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isGameOver
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Congratulations!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your final score: $score/${trademarks.length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Score: $score',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      trademarks[currentIndex].imagePath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Type the trademark/brand name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          userInput = value;
                        });
                      },
                      onSubmitted: (_) => checkAnswer(),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: checkAnswer,
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      style: TextStyle(
                        color: message.contains('Correct') ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}