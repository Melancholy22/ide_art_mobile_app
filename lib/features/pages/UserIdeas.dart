import 'dart:math';
import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/drop_down_menu.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';
import 'package:ide_art_mobile_app/components/top_app_bar.dart';
import '../../models/ArtIdea.dart';
import '../../models/FilterType.dart';

class UserIdeas extends StatelessWidget {
  const UserIdeas({super.key});

  @override
  Widget build(BuildContext context) {
    FilterType artIdeaType = FilterType.PEOPLE;
    final ideaController = TextEditingController();
    var people = [], places = [], objects = [], ideas = [], animals = [];
    var adverbs = [" aggressively", " casually", " quickly", " hastily", " slowly", " cautiously", " hesitantly", " clumsily", " carefully", " creepily"];
    var verbs = [" eating in ", " swimming in ", " sitting in ", " taking a stroll in ", " wandering around ", " crying in ", " laughing in ", " smiling in ", " frowning in ", " relaxing in ", " frolicking in ", " admiring a picture of ", " tiptoeing around ", " sneaking around "];
    var connectors = [" in the presence of ", " with ", " surrounded by ", " while staring at ", " accompanied by ", " joined by ", " while holding ", " while writing a poem about ", " while singing a song about ", " while publishing a paper on ", " while presenting a speech on "];
    DropdownButton1 drop1 = DropdownButton1(list: ["People", "Places", "Objects", "Ideas", "Animals", "Scenarios"]);
    String dis  = "";

    Future<void> createArtIdea() async {
      try {
        final model = ArtIdea(
        idea: ideaController.text,
        filter: artIdeaType);
        final request = ModelMutations.create(model);
        final response = await Amplify.API.mutate(request: request).response;

        final createdArtIdea = response.data;
        if (createdArtIdea == null) {
          safePrint('errors: ${response.errors}');
          return;
        }
        safePrint('Mutation result: ${createdArtIdea.id}');
      } on ApiException catch (e) {
        safePrint('Mutation failed: $e');
      }
    }

    Future<List<ArtIdea?>> queryListItems(int i) async {

      try {
        final request = ModelQueries.list(
          ArtIdea.classType,
          where: ArtIdea.FILTER.eq(artIdeaType),
        );
        final response = await Amplify.API.query(request: request).response;

        final items = response.data?.items;
        if (items == null) {
          safePrint('errors: ${response.errors}');
          return <ArtIdea?>[];
        }
        // safePrint(items);
        var intValue = Random().nextInt(items.length);
        if(i > 0)
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(items[intValue]!.idea),
          // ));
          dis = items[intValue]!.idea;

        return items;
      } on ApiException catch (e) {
        safePrint('Query failed: $e');
      }
      return <ArtIdea?>[];
    }

    Future<void> check(String string) async{
      // safePrint("Value: " + _DropdownButtonExampleState.dropdownValue);
      switch(string){
        case "People" : { artIdeaType = FilterType.PEOPLE;  }
        break;

        case "Places" : { artIdeaType = FilterType.PLACES;  }
        break;

        case "Objects" : { artIdeaType = FilterType.OBJECTS;  }
        break;

        case "Ideas" : { artIdeaType = FilterType.IDEAS;  }
        break;

        case "Animals" : { artIdeaType = FilterType.ANIMALS;  }
        break;

        default: {safePrint("Error in checking filter type"); }
        break;
      }
      safePrint(artIdeaType);
    }

    Future<void> generateScenario () async {
      var rng = Random();
      artIdeaType = FilterType.PEOPLE;
      people = await queryListItems(0);
      artIdeaType = FilterType.PLACES;
      places = await queryListItems(0);
      artIdeaType = FilterType.OBJECTS;
      objects = await queryListItems(0);
      artIdeaType = FilterType.ANIMALS;
      animals = await queryListItems(0);
      artIdeaType = FilterType.IDEAS;
      ideas = await queryListItems(0);

      int scenarioType = rng.nextInt(4);
      String scenes = "";
      switch(scenarioType) {
        case 0:
          scenes = people[rng.nextInt(people.length)]!.idea + verbs[rng.nextInt(verbs.length)] + places[rng.nextInt(places.length)]!.idea;
          break;
        case 1:
          scenes = people[rng.nextInt(people.length)]!.idea + adverbs[rng.nextInt(adverbs.length)] + verbs[rng.nextInt(verbs.length)] + places[rng.nextInt(places.length)]!.idea + connectors[rng.nextInt(connectors.length)] + objects[rng.nextInt(objects.length)]!.idea.toLowerCase();
          break;
        case 2:
          scenes = people[rng.nextInt(people.length)]!.idea + adverbs[rng.nextInt(adverbs.length)]  + verbs[rng.nextInt(verbs.length)] + places[rng.nextInt(places.length)]!.idea;
          break;
        case 3:
          scenes = people[rng.nextInt(people.length)]!.idea + verbs[rng.nextInt(verbs.length)] + places[rng.nextInt(places.length)]!.idea + connectors[rng.nextInt(connectors.length)] + objects[rng.nextInt(objects.length)]!.idea.toLowerCase();
          break;
        default: 
      }
      safePrint(scenes);
      dis = scenes;
    }

    void displayStuff() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(dis),
          );
        },
      );
    }

    return Scaffold(
      appBar: topBar(),
      body: Center(
        child: 
          Column(
            children: [
              drop1,
              ElevatedButton(
                child: Text('Generate Idea'),
                onPressed: () {
                  String str= drop1.getDrop(); 
                  if(str != "Scenarios")
                    check(str).whenComplete(() => queryListItems(1)).whenComplete(() => displayStuff());
                  else
                    generateScenario().whenComplete(() => displayStuff());
                },
              ),
              // ElevatedButton(
              //   child: Text('Generate Scenario'),
              //   onPressed: () {
              //     generateScenario();
              //   },
              // ),
              DropdownButtonExample(),
              MyTextField(
                controller: ideaController, 
                hintText: 'Enter an idea', 
                obscureText: false,
              ),
              ElevatedButton(
                child: Text('Upload Idea'),
                onPressed: () {
                  check(_DropdownButtonExampleState.dropdownValue).whenComplete(() => createArtIdea());
                },
              ),

            ],
          ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const List<String> list = <String>["People", "Places", "Objects", "Ideas", "Animals"];
  static String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
