import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/components/my_textfield.dart';
import '../../models/ArtIdea.dart';
import '../../models/FilterType.dart';

class UserNotifs extends StatelessWidget {
  const UserNotifs({super.key});
  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    FilterType artIdeaType = FilterType.PEOPLE;
    final ideaController = TextEditingController();

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

    Future<List<ArtIdea?>> queryListItems() async {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text("Sending Message"),
      // ));
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
        return items;
      } on ApiException catch (e) {
        safePrint('Query failed: $e');
      }
      return <ArtIdea?>[];
    }

    Future<void> check() async{
      // safePrint("Value: " + _DropdownButtonExampleState.dropdownValue);
      switch(_DropdownButtonExampleState.dropdownValue){
        case "Person" : { artIdeaType = FilterType.PEOPLE;  }
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

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(113, 203, 255, 100),
        elevation: 0,
        title:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
          // ignore: prefer_const_constructors
          Text(
            'ideArt',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  signOutCurrentUser();
                }, 
                icon: Icon(Icons.density_medium),
              ) 
            ],
          )
        ]),
      ),
      body: Center(
        child: 
          Column(
            children: [
              DropdownButtonExample(),
              MyTextField(
                controller: ideaController, 
                hintText: 'Enter an idea', 
                obscureText: false,
              ),
              ElevatedButton(
                child: Text('Upload Idea'),
                onPressed: () {
                  check().whenComplete(() => createArtIdea());
                },
              ),
              ElevatedButton(
                child: Text('Generate Idea'),
                onPressed: () {
                  check().whenComplete(() => queryListItems());
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
