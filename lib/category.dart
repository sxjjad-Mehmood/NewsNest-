import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Model/CategoryModel.dart';
import 'package:newsapp/view/apirepositry.dart';

import 'Detalis.dart';
class categoriesscreen extends StatefulWidget {
  const categoriesscreen({super.key});

  @override
  State<categoriesscreen> createState() => _categoriesState();
}

class _categoriesState extends State<categoriesscreen> {
  List<String> category=[
    "general", "sports", "heath", "science", "technology","entertainment","business"
  ];
  String categoryname = "general";
var selected;

  @override
  Widget build(BuildContext context) {
   final height= MediaQuery.of(context).size.height*1;
   final width=MediaQuery.of(context).size.width*1;
    final datetimeformate =DateFormat("MMMM dd,yyyy");
    final view =viewmodel();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context ,index){
                return InkWell(
                  onTap: (){
                  categoryname = category[index];
                  setState(() {

                  });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height*.011,
                      decoration: BoxDecoration(
                        color:categoryname == category[index] ?Colors.brown: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Center(child: Text(category[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),
                      ),

                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: FutureBuilder(
                  future: view.getcategory(categoryname),
                  builder: (context ,AsyncSnapshot<CategoryModel> snapshot){

                      if(snapshot.connectionState==ConnectionState.waiting){
                        return SpinKitCircle(color: Colors.yellow,);
                      }
                      else{
                        return ListView.builder(
                            itemCount:  snapshot.data!.articles!.length,
                            itemBuilder: (context ,index){
                          DateTime datetime= DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => detalis(
                                img:snapshot.data!.articles![index].urlToImage.toString() ,
                                title: snapshot.data!.articles![index].title.toString(),
                                source: snapshot.data!.articles![index].source!.name.toString(),
                                content: snapshot.data!.articles![index].content.toString(),
                                datetime:datetimeformate.format(datetime),

                              )
                              )
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                     ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                          height: height*.18,
                                        width: width*.3,
                                        errorWidget: (context , url, error)=> Icon(Icons.no_photography_rounded,color: Colors.red,),
                                        alignment: Alignment.center,
                                          imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fadeInDuration: Duration(seconds: 1)),
                                    ),

                                  Expanded(
                                    child: SizedBox(
                                      height: height*.18,

                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Column(
                                          children: [
                                            Text(snapshot.data!.articles![index].title.toString(),
                                              overflow:TextOverflow.ellipsis ,
                                                maxLines: 3,
                                                style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15,fontStyle: FontStyle.italic),
                                              ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),
                                                overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Text(datetimeformate.format(datetime).toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,fontStyle: FontStyle.italic)),


                                              ],

                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                        }
                        );
                      }


                  }),
            )
            
          ],
        ),
      ),
    );
  }
}
