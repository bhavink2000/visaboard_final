import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool? isLoading;
  bool isShow = false;
  String access_token = "",token_type = "";
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        isLoading = false;
      });
    });
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  String search = "";
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("CHATS",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.menu_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  Flexible(
                    child: Card(
                      elevation: 8,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40))
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS)
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: search.isEmpty
                            ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.search,color: PrimaryColorOne),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.close, color: PrimaryColorOne,),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: Center(
                  child: Image.asset("assets/gif/coming-soon.gif"),
                ),
                /*child: isLoading == false
                    ? AnimationLimiter(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 9,
                    itemBuilder: (context, index){
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: Stack(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height / 12,
                                    ), //Container
                                    Card(
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                      shadowColor: PrimaryColorOne.withOpacity(0.3),
                                      child: Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 1.2,
                                          height: MediaQuery.of(context).size.height / 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(60, 5, 0, 0),
                                            child: Text("VisaBoard",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),),
                                          ),
                                        ),
                                      ),
                                    ), //Container
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: PrimaryColorOne,
                                        child: Text("${index+1}",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                      ),
                                    ), //Container
                                  ],
                                )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : CenterLoading(),*/
              ),
            )
          ],
        ),
      ),
    );
  }
}
