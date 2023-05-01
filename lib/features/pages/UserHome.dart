import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ide_art_mobile_app/common/utils/colors.dart';
import 'package:ide_art_mobile_app/common/utils/styles.dart';
import '../../components/gradient_text.dart';
import '../../components/top_app_bar.dart';
import 'package:ide_art_mobile_app/components/UserPost.dart';
import 'package:ide_art_mobile_app/components/ChallengeTile.dart';
import 'challengemodel.dart';
import '../../models/UserPosts.dart';


class UserHome extends StatelessWidget {

  final List<UserPosts> _posts = [
    UserPosts(id:"f68e5ed3-9ee1-4427-ac51-e89ddd567a01", author: "robjb822", title: "THE Billy", description:"THE BRONCO", image:"https://react-art-website-image-storage231705-staging.s3.us-west-1.amazonaws.com/public/images/fbcc9b5b-7734-4bec-a5e2-5a39eb015396BillyBronco.jpg"),
    UserPosts(id:"2e91a1dc-a8d7-4696-8b47-84c365086d2a", author: "Meloncholy", title: "PIcture", description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", image:"https://static.wikia.nocookie.net/konosuba/images/4/4d/Prev_Chomusuke.png/revision/latest?cb=20161216071437"),
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText("Explore Challenges",
                      textStyle: titleStyle,
                      colors: ideArtColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
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
                padding: EdgeInsets.only(top:16.0, left:16.0, right:16.0),
                child: GradientText(
                  'Recent Posts',
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
