import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  final String child;
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
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Title", 
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins', 
                          fontWeight: FontWeight.w500
                          ),
                      ),
                      Text(
                        "Username", 
                        style: TextStyle(
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
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
              child: Center(
                child: Text(
                  child, 
                  style: const TextStyle(fontSize: 40),
                  ),
              ) 
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Container(
                  height: 90,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lorem, 
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
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}