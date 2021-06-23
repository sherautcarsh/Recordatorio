import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget{
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>{
  String filterType = "timeline";
  bool show = true,show2=true,show3=true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            AppBar(
              backgroundColor: Colors.redAccent,
              automaticallyImplyLeading: false,
              toolbarHeight: 75,
              elevation: 5,
              centerTitle: true,
              title: Text("Tasks & Projects",
                style: TextStyle(fontSize: 30, fontFamily: 'arial',),
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton(icon:Icon(Icons.short_text, color: Colors.white,size: 30,)
                ),
              ],
            ),
          Container(
            height: 60,
            color: Colors.redAccent,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){changeFilter("timeline");},
                      child: Text("Timeline", style: TextStyle(
                        color: Colors.white,
                        fontSize: 26
                      ),)
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 4,
                      width: 205,
                      color: (filterType=="timeline")?Colors.white:Colors.transparent,
                    ),
                    ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){changeFilter("projects");},
                        child: Text("Projects", style: TextStyle(
                            color: Colors.white,
                            fontSize: 26
                        ),)
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 4,
                      width: 205,
                      color: (filterType=="projects")?Colors.white:Colors.transparent,
                    ),
                  ],
                ),
              ],
              ),
            ),
              (filterType=="timeline")?
              Stack(
                children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    height: 60,
                    color: Colors.white70,
                    child: Row(
                      children: [
                        SizedBox(height: 0,width:10),
                        Text("Today", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                        IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: changeShow())

                      ],
                    ),
                ),(show)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Run away Happily", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Find a girlfriend", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Come back sad", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          )
                        ],
                      ):Container(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        height: 60,
                        color: Colors.white70,
                        child: Row(
                          children: [
                            SizedBox(height: 0,width:10),
                            Text("Tomorrow", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: changeShow2())

                          ],
                        ),
                      ),
                  (show2)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Plan Better", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Arranged Marriage?", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        height: 60,
                        color: Colors.white70,
                        child: Row(
                          children: [
                            SizedBox(height: 0,width:10),
                            Text("Later", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: changeShow3())

                          ],
                        ),
                      ),
                  (show3)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Make a to-do app", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Accept your fate", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),


                ],)]):
                  Container(


                  )
        ],
      ),
      ],
    ),);
  }
  changeFilter(String filter){
    print(filter);
    filterType = filter;
    setState(() {

    });

}
  changeShow(){
    print(show);
    show = !show;
    setState(() {

    });
  }
  changeShow2(){
    print(show2);
    show2 = !show2;
    setState(() {

    });
  }
  changeShow3(){
    print(show3);
    show3 = !show3;
    setState(() {

    });
  }
}