import 'package:flutter/material.dart';
import '../../models/UserPosts.dart';


class UserPost extends StatelessWidget {
  final UserPosts child;
  final String lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ";

  UserPost({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(  
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profilepic.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.title!, 
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins', 
                          fontWeight: FontWeight.w500
                          ),
                      ),
                      Text(
                        child.author!, 
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins', 
                          fontWeight: FontWeight.w400
                          ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 230,
              decoration: BoxDecoration(  
                    image: DecorationImage(
                      image: NetworkImage(
                      child.image!),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  child.description!, 
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins', 
                    fontWeight: FontWeight.normal
                    ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical:8.0),
                  child: Text(
                    "1 minute ago", 
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: 'Poppins', 
                      fontWeight: FontWeight.normal
                      ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}