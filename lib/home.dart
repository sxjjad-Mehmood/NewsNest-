import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Detalis.dart';
import 'package:newsapp/Model/HeadlineModel.dart';
import 'package:newsapp/category.dart';
import 'package:newsapp/view/apirepositry.dart';

import 'Model/CategoryModel.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}
 enum FilterList{
  bbc_news, Al_Jazeera,Ary_News,CBC_News,ESPN_Cric,New_York

}
class _homeState extends State<home> {

  FilterList? selected;
 var name="bbc-news";

  final view =viewmodel();
  final datetimeformate =DateFormat("MMMM dd,yyyy");
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height*1;
    final width=MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => categoriesscreen()));
          },
          icon: Image.asset("images/icon.png",height: 30,),




        ),
        title: Text("News", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      centerTitle: true,
   toolbarHeight: 70,
        actions: [
PopupMenuButton<FilterList>(
  iconSize: 30 ,
  initialValue: selected,
  onSelected: (FilterList item){
    if(FilterList.New_York.name==item.name){
      name="new-york-magazine";
    }
    if(FilterList.ESPN_Cric.name==item.name){
      name="espn-cric-info";
    }
    if(FilterList.CBC_News.name==item.name){
      name ="cbc-news";
    }
    if (FilterList.Ary_News.name==item.name){
      name="ary-news";
    }
    if(FilterList.Al_Jazeera.name==item.name){
      name="al-jazeera-english";
    }
    if(FilterList.bbc_news.name==item.name){
      name="bbc-news";
    }

    setState(() {
      selected=item;
    });
  },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>
[
  PopupMenuItem<FilterList>(
    value:FilterList.Al_Jazeera ,
      child: Text("Al_Jazeera",style: TextStyle(fontSize: 20),)
  ),
  PopupMenuItem<FilterList>(
      value:FilterList.Ary_News ,
      child: Text("ARY News",style: TextStyle(fontSize: 20),)
  ),
  PopupMenuItem<FilterList>(
      value:  FilterList.CBC_News ,
      child: Text("CBC News",style: TextStyle(fontSize: 20),)
  ),
  PopupMenuItem<FilterList>(
      value:FilterList.ESPN_Cric ,
      child: Text("ESPN_Cric",style: TextStyle(fontSize: 20),)
  ),
  PopupMenuItem<FilterList>(
      value:FilterList.New_York ,
      child: Text("New York",style: TextStyle(fontSize: 20),)
  ),
    PopupMenuItem<FilterList>(
        value:FilterList.bbc_news ,
        child: Text("BBc News",style: TextStyle(fontSize: 20),)
    ),


    ],




)
        ],
      ),
      body :SafeArea(
        child: ListView(
          itemExtent: MediaQuery.of(context).size.height*.5,

         scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.5,
            child: FutureBuilder<HeadlineModel>(
              future:view.getapi(name) ,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFadingCircle(
                    size: 50,
                    color: Colors.yellow,
                  );
                }
                else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                     itemCount: snapshot.data!.articles!.length,
                     itemBuilder: (context,index){
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
                      child: SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*.6,
                              width: MediaQuery.of(context).size.width*.9,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height *.01),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(

                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fadeInDuration: Duration(seconds: 1),
                      fit: BoxFit.cover,errorWidget: (context, url,error)=> Icon(Icons.no_photography,color: Colors.red,),
                                  ),
                                ),
                              ),

                            ),
                            Positioned(
                             bottom: 6,
                              child: Card(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*.2,
                                  width: MediaQuery.of(context).size.width*.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      Container(

                                          width: MediaQuery.of(context).size.width*.6,
                                          child: Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis
                                            ,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.bold),)
                                      ),
                                      Spacer(),
                                      Container(
                                        width: MediaQuery.of(context).size.width*.7,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween
                                          ,children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis
                                              ,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15,fontWeight: FontWeight.w500),),
                                            Text(datetimeformate.format(datetime),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis
                                              ,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),)

                                          ],
                                        ),
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
                  });
                }
              }
            )
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                  future: view.getcategory("general"),
                  builder: (context ,AsyncSnapshot<CategoryModel> snapshot){

                    if(snapshot.connectionState==ConnectionState.waiting){
                      return SpinKitCircle(color: Colors.yellow,);
                    }
                    else{
                      return ListView.builder(

                          shrinkWrap: true,

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
                                          alignment: Alignment.center,
                                          imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fadeInDuration: Duration(seconds: 1),
                                        errorWidget: (context,url, error) => Icon(Icons.no_photography_rounded, color: Colors.red,),

                                      ),

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
            ),
          ],

        ),
      )


    );
  }
}
