import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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


class UserHome extends StatefulWidget {
  const UserHome({super.key});

    @override
  State<UserHome> createState() => _UserHomeState();

}

class _UserHomeState extends State<UserHome>{

  List<UserPosts> _posts = [];

  final List<Challenge> _challenges = [
    Challenge(image: "https://static.wikia.nocookie.net/pusheenthecat/images/1/14/Aboutpusheen.gif/revision/latest/scale-to-width-down/325?cb=20140728143155", title: "Pusheen", description: "pushe"),
    Challenge(image: "https://image.sciencenordic.com/1969865.webp?imageId=1969865&width=960&height=548&format=jpg", title: "Mushrooms", description: "shroom"),
    Challenge(image: "https://ih1.redbubble.net/image.3387563814.4627/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg", title: "Ranni", description: "witch"),
    Challenge(image: "https://pusheen.com/wp-content/themes/pusheen-custom/img/about-pusheen.png", title: "Pusheen", description: "pushe"),

  ];

  final controller = ScrollController();
  final limit = 4;
  bool hasMore = true;
  bool isLoading = false;
  PaginatedResult<UserPosts>? firstPageData;

  @override
  void initState(){
    super.initState();
    initLoad();
    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Future initLoad() async {
    final firstRequest = ModelQueries.list<UserPosts>(
      UserPosts.classType, 
      limit: limit,
      );
    final firstResult = await Amplify.API.query(request: firstRequest).response;
    firstPageData = firstResult.data;
    var items = firstPageData?.items;
    final List newItems = items!.whereType<UserPosts>().toList();
    setState(() {
      _posts.addAll(newItems as Iterable<UserPosts>);
      safePrint("adding items");
      safePrint(_posts);
    });
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;

    firstPageData = await queryPaginatedData();
    setState(() {
      hasMore = firstPageData?.hasNextResult ?? false;
    });
    if (hasMore == true){
      var items = firstPageData?.items;
      final List newItems = items!.whereType<UserPosts>().toList();
      setState(() {
        isLoading = false;
        _posts.addAll(newItems as Iterable<UserPosts>);
        safePrint("adding items");
        safePrint(_posts);
      });
    }
  }

  Future<PaginatedResult<UserPosts>?> queryPaginatedData() async {
    if (firstPageData?.hasNextResult ?? false) {
      final secondRequest = firstPageData!.requestForNextResult;
      final secondResult =
          await Amplify.API.query(request: secondRequest!).response;
          final secondPageData = secondResult.data;
      return secondPageData;
    } else {
      return firstPageData;
    }
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      _posts.clear();
      initLoad();
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: topBar(),

      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView (
              controller: controller,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText("Explore Challenges",
                        textStyle: titleStyle,
                        colors: ideArtColors,
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    // isRepeatingAnimation: true,
                    // repeatForever: true,
                    // pause: const Duration(milliseconds: 0),
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
                  itemCount: _posts.length + 1,
                  itemBuilder: (context, index){
                    if(index < _posts.length){
                    return UserPost(
                      child: _posts[index],
                      );
                     }
                     else{
                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical:16.0), 
                        child: Center(
                          child: hasMore 
                          ? const CircularProgressIndicator()
                          : const Text("No more data")
                        ),
                      );
                     }
                  }),
              ],
            ),
      ),
    );
  }
}
