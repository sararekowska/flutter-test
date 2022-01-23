import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = <WordPair>{};

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if(item.isOdd) return const Divider();

        final index = item ~/ 2;

        if(index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(title: Text(pair.asPascalCase, style: const TextStyle
    (fontSize: 19.0)),
    trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, 
    color: alreadySaved ? Colors.red : null),
    onTap: () {
      setState(() {
        if(alreadySaved) {
          _savedWordPairs.remove(pair);
        } else {
          _savedWordPairs.add(pair);
        }
      });
    }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Wordpair Generator")),
        body: _buildList()
    );
  }
}