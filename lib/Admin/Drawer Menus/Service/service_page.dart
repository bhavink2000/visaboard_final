import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';


class ServicePage extends StatefulWidget {
  ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  var selectedcategory;
  var selectedcountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Service",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.5,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Visa Assistance Categories",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 12,
                        itemBuilder: (context, index){
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedcategory = index;
                                        });
                                        print("Current Index  =>> $selectedcategory  index ==>>$index");
                                      },
                                      child: selectedcategory == index ? Card(
                                        elevation: 6,
                                        shadowColor: PrimaryColorThree,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Color(0xff13c6d1)),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: Text("Student",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16,color: Colors.white),),
                                          ),
                                        ),
                                      ) : Card(
                                        elevation: 6,
                                        shadowColor: PrimaryColorThree,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Colors.white),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: Text("Student",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16,color: PrimaryColorOne),),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.5,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Visa Assistance Countries",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 19,
                        itemBuilder: (context, index){
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedcountry = index;
                                        });
                                        print("Current Index  =>> $selectedcountry  index ==>>$index");
                                      },
                                      child: selectedcountry == index ? Card(
                                        elevation: 6,
                                        shadowColor: PrimaryColorThree,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Color(0xff13c6d1)),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: Text("India",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16,color: Colors.white),),
                                          ),
                                        ),
                                      ) : Card(
                                        elevation: 6,
                                        shadowColor: PrimaryColorThree,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),color: Colors.white),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: Text("India",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16,color: PrimaryColorOne),),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Services",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),),
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index){
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xff13c6d1),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("Free",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      topLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(25),
                                                      bottomLeft: Radius.circular(25)
                                                  ),
                                                  color: Colors.white,
                                                  image: DecorationImage(image: AssetImage("assets/image/info_shape.png"),fit: BoxFit.fitHeight)
                                              ),
                                              padding: EdgeInsets.all(8),
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text("Visa File SOP",style: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne),),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Kindly find below table of Time Estimation for all services :",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Table 1",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 17),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (context, index){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TapToExpand(
                              color: Color(0xff13c6d1),
                              content: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Chosen Service",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Admission",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Time Window(Estimated)",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("From 9 to 90 Working Days",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "What We Do? & How Do We Operate?",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("VisaBoard liaisons with a foreign education provider requesting admission for the agency/agent’s applicant based on the information & documents as received.",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              title: Expanded(
                                child: Text(
                                    'Assistance in Submission of Visa File*',
                                    style: TextStyle(color: Colors.white, fontSize: 12  ,fontFamily: Constants.OPEN_SANS)
                                ),
                              ),
                              onTapPadding: 10,
                              scrollable: true,
                              borderRadius: 20,
                              boxShadow: [BoxShadow(color: Color(0xff13c6d1).withOpacity(0.2), spreadRadius: 1, blurRadius: 1)]
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Spacial Note",style: TextStyle(fontSize: 16,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_circle_right),
                        SizedBox(width: 5,),
                        Expanded(child: Text("All of the above services and given time frame are subjected to having received all required, sufficient & complete set of documents listed on the VisaBoard portal.",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,),)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_circle_right),
                        SizedBox(width: 5,),
                        Expanded(child: Text("Application fees of education provider, visa fees, medical fees, insurance fees and any other applicable charges are to be paid by the agency/agent in advance in order to process the application.",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,),)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_circle_right),
                        SizedBox(width: 5,),
                        Expanded(child: Text("Commission if applicable shall be shared on 70% & 30% basis (70% Agency/Agent & 30% VisaBoard)",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,),)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 5, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_circle_right),
                        SizedBox(width: 5,),
                        Expanded(child: Text("Commission is disbursed by foreign education provider usually takes about 3 months (may vary*) only after the applicant has been successfully enrolled and has paid up the first year tuition fee in advance.",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,),)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Table 2",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 17),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (context, index){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TapToExpand(
                              color: Color(0xff13c6d1),
                              content: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Chosen Service",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Home Valuation Report",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Time Window(Estimated)",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Up to 3 Working Days",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Documents Required",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("""Sale deed, Gift deed, Agreement deed, Partition deed, Trust deed, Inherited, Electricity bill,
                                                Allotment letter, Municipal Property Tax bill.
                                                Lease deed, Purchase deed, Latest 7/12 8/A extract
                                                *Documents should be issued by the competent authority""",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              title: Expanded(
                                child: Text(
                                    'Home Valuation Report',
                                    style: TextStyle(color: Colors.white, fontSize: 12  ,fontFamily: Constants.OPEN_SANS)),
                              ),
                              onTapPadding: 10,
                              scrollable: true,
                              borderRadius: 20,
                              boxShadow: [BoxShadow(color: Color(0xff13c6d1).withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Table 3",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 17),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TapToExpand(
                              color: Color(0xff13c6d1),
                              content: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Chosen Service",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Translation Services",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Time Window(Estimated)",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Up to 3 Working Days",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Documents Required",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Translation services from Gujarati to English only-NOT NOTARIZED",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              title: Expanded(
                                child: Text(
                                    'Translation Services',
                                    style: TextStyle(color: Colors.white, fontSize: 12  ,fontFamily: Constants.OPEN_SANS)),
                              ),
                              onTapPadding: 10,
                              scrollable: true,
                              borderRadius: 20,
                              boxShadow: [BoxShadow(color: Color(0xff13c6d1).withOpacity(0.2), spreadRadius: 1, blurRadius: 1)]
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Table 4",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 17),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TapToExpand(
                              color: Color(0xff13c6d1),
                              content: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 4,
                                          child: Text(
                                              "Chosen Service",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("TT (Telegraphic Transfer)",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Time Window(Estimated)",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("Up to 5 Working Days",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 11,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: PaddingField,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          child: Text(
                                              "Documents Required",
                                              style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold))
                                      ),
                                      CardDots,
                                      Expanded(
                                        child: Container(
                                            padding: PaddingField,
                                            child: Text("We will guide you with the payment procedure for Telegraphic Transfer-This service is FREE OF COST.",
                                                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10,color: Colors.white))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              title: Expanded(
                                child: Text(
                                    'TT (Telegraphic Transfer)',
                                    style: TextStyle(color: Colors.white, fontSize: 12  ,fontFamily: Constants.OPEN_SANS)),
                              ),
                              onTapPadding: 10,
                              scrollable: true,
                              borderRadius: 20,
                              boxShadow: [BoxShadow(color: Color(0xff13c6d1).withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
