import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class detalis extends StatefulWidget {
String img;
String title;
String content;
String source;
String datetime;
detalis({super.key,
  required this.img,
    required this.title,
    required this.source,
    required this.content,
    required this.datetime,
  });

  @override
  State<detalis> createState() => _detalisState();
}

class _detalisState extends State<detalis> {
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height*1;
    final width=MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
      ),
      body: Stack(
        children: [
          Container(
            height: height*.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                child: CachedNetworkImage(imageUrl: widget.img,fit: BoxFit.cover,
                errorWidget: (context ,url ,error)=> Icon(Icons.no_photography_rounded,color: Colors.red,)),
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                color: Colors.white,
              ),
             margin: EdgeInsets.only(top: height*.4),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Text(widget.title,style: TextStyle(
                      fontSize: 25,fontWeight: FontWeight.bold
                    ),),
                    SizedBox(
                      height: height*.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.source.toString(),style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.w500
                        ),),
                        Text(widget.datetime,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    SizedBox(
                      height: height*.03,
                    ),
                    Text(widget.content,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)

                  ],

                ),
              ),

            ),
          )
        ],

      )

    );
  }
}
