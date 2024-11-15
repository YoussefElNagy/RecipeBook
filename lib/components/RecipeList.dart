import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  Future getData() async {
    String api = 'https://dummyjson.com/recipes';
    var response = await get(Uri.parse(api));
    Map<String, dynamic> myData = jsonDecode(response.body);

    List data = myData['recipes'];
    List recipeNames = data.map((e) => e['name']).toList();
    print(recipeNames);
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Recipe"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        border: Border.all(color: Colors.amber),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data[index]['name']),
                            CircleAvatar(
                              radius: 30,
                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data[index]['image'],
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'Duration: ${snapshot.data[index]['prepTimeMinutes'] + snapshot.data[index]['cookTimeMinutes']} minutes',
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/ingredients', arguments: {
                            "ingreds": snapshot.data[index]
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
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
              iconSize: 40,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recipes');
              },
              icon: Icon(Icons.food_bank),
              iconSize: 40,
            ),
            // Add more icons if needed
          ],
        ),
      ),
    );
  }
}
