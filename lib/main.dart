import 'package:flutte_pokedex/helper/customRoute.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/pages/homePageBody.dart';
import 'package:flutte_pokedex/pages/pokemonDetailPage.dart';
import 'package:flutte_pokedex/pages/pokemonListPage.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MainModel model = new MainModel();
  Pokemon pokemonModel;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'circular',
            primarySwatch: Colors.blue,
          ),
          // home: MyHomePage(),
          routes: {
            '/': (BuildContext context) => MyHomePage(model: model),
          },
          onGenerateRoute: (RouteSettings settings ){
              final List<String> pathElements = settings.name.split('/');
                if (pathElements[0] != '') {
                  return null;
                }
                if(pathElements[1].contains('detail')){
                  var id  = int.tryParse(pathElements[2]);
                  pokemonModel = model.allPokemon.firstWhere((x) { return x.id == id;});
                  return CustomRoute<bool>(builder:(BuildContext context)=> PokemonDetailPage(model: pokemonModel,));
                }
                else if(pathElements.contains('pokemonList')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> PokemonListPage(model: model,));
                }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final MainModel model;
  const MyHomePage({this.model});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isViewAll = false;
  double viewAllHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfff4f4f4), body: HomePageBody());
  }
}
