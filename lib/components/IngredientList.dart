import 'package:flutter/material.dart';
class IngredientList extends StatefulWidget {
  const IngredientList({super.key});

  @override
  State<IngredientList> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  @override
  Widget build(BuildContext context) {

    Map ingredients=  ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text("${ingredients['ingreds']['name']}",
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.brown[700]) , ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),

              decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: Colors.amber
                ),
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(ingredients['ingreds']['name'],style: TextStyle(fontSize: 16,color: Colors.brown[850]),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 80,
                        child: Image.network(ingredients['ingreds']['image'])),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients['ingreds']['ingredients'].length,
                itemBuilder: (context,index)=> Card(
                  color: Colors.amber[100],
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                    child: ListTile(
                      title: Text(ingredients['ingreds']['ingredients'][index],style: TextStyle(color: Colors.brown[700],fontWeight: FontWeight.w500),),
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: Icon(Icons.home),
              color: Colors.brown[700],
              iconSize: 40,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recipes');
              },
              icon: Icon(Icons.food_bank),
              iconSize: 40,
              color: Colors.brown[700],
            ),
            // Add more icons if needed
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
