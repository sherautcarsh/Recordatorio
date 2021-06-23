import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget{
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>{
  String filterType = "timeline";
  bool today = true,tomorrow = false,later = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF3CACA),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                        TextButton(onPressed: (){
                          today = !today;
                          print(today);
                          setState(() {

                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0,),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:12),
                              Text("Today", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Color(0xFFF3CACA);// Use the component's default.
                              },
                            ),
                          ),
                        ),

                //TODAY STARTS HERE
                (today)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Run away Happily", style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 20),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
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
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Come back sad", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          )
                        ],
                      ):Container(),

                      //TOMORROW STARTS HERE
                      TextButton(onPressed: (){
                        tomorrow = !tomorrow;
                        print(tomorrow);
                        setState(() {

                        });
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:10),
                              Text("Tomorrow", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFF3CACA);// Use the component's default.
                            },
                          ),
                        ),
                      ),
                  (tomorrow)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
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
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Arranged Marriage?", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),

                      //LATER STARTS HERE
                      TextButton(onPressed: (){
                        later = !later;
                        print(later);
                        setState(() {

                        });
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 60,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(height: 0,width:10),
                              Text("Later", style: TextStyle(color: Colors.redAccent,fontSize: 20),),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Color(0xFFF3CACA);// Use the component's default.
                            },
                          ),
                        ),
                      ),
                  (later)?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(6, 6, 6, 0),
                            padding: EdgeInsets.all(2),
                            height: 50,
                            color: Color(0xFFCE3636),
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
                            color: Color(0xFFCE3636),
                            child: Row(
                              children: [
                                SizedBox(height: 0,width:10),
                                Text("Accept your fate", style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ):Container(),


                ],):
                  Container(


                  ),
        ],
      ),
      ],
    ),);
  }
  changeFilter(String filter){
    filterType = filter;
    setState(() {

    });

}
  changeShow(bool show){
    print(show.toString());
    show = !show;
    setState(() {

    });
  }
}