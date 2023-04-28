import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';
import '../../components/gradient_text.dart';
import '../../components/top_app_bar.dart';
import 'package:ide_art_mobile_app/components/UserPost.dart';
import 'package:ide_art_mobile_app/components/ChallengeTile.dart';
import 'challengemodel.dart';

class UserHome extends StatelessWidget {

  final List _posts = [
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
  ];

  final List<Challenge> _challenges = [
    Challenge(image: "https://static.wikia.nocookie.net/pusheenthecat/images/1/14/Aboutpusheen.gif/revision/latest/scale-to-width-down/325?cb=20140728143155", title: "Pusheen", description: "pushe"),
    Challenge(image: "https://image.sciencenordic.com/1969865.webp?imageId=1969865&width=960&height=548&format=jpg", title: "Mushrooms", description: "shroom"),
    Challenge(image: "https://ih1.redbubble.net/image.3387563814.4627/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg", title: "Ranni", description: "witch"),
    Challenge(image: "https://pusheen.com/wp-content/themes/pusheen-custom/img/about-pusheen.png", title: "Pusheen", description: "pushe"),

  ];


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: topBar(),

      body: ListView (
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: GradientText(
                  'Explore Challenges',
                  style: TextStyle(
                    fontSize: 24, 
                    fontFamily: 'Poppins', 
                    fontWeight: FontWeight.bold
                    ),
                  gradient: ideArtColor1,
                ),
              ),
              
              // Challenges
                Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _challenges.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return ChallengeTile(
                      child: _challenges[index],
                    );
                  }),
                ),

          
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: GradientText(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 24, 
                    fontFamily: 'Poppins', 
                    fontWeight: FontWeight.bold
                    ),
                  gradient: ideArtColor1,
                ),
              ),
              
              // UserPosts
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const ClampingScrollPhysics(),
                itemCount: _posts.length,
                itemBuilder: (context, index){
                  return UserPost(
                    child: _posts[index],
                    );
                }),
            ],
          ),
    );
  }
}
