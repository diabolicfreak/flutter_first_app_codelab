import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Welcome to flutter",
      home: new RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    print("build");
    return new Scaffold(
      appBar: new AppBar(title: new Text("Welcome to flutter"),),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    print("_buildSuggestions");
    return new ListView.builder(
      itemBuilder: (context, i){
        if(i.isOdd) return new Divider();
        final index = i~/2;
        if(index>=_suggestions.length){
          print("Added");
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  _buildRow(WordPair pair){
    print("_buildRow");
    bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont,),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        print("tapped");
        setState((){
          if(alreadySaved){
            setState(()=>_saved.remove(pair));
          }else{
            setState(()=>_saved.add(pair));
          }
        });
      },
    );
  }
}
