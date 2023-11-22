// ignore_for_file: missing_return

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:visaboard_final/Admin/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_final/Admin/App%20Helper/Ui%20Helper/error_helper.dart';

import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  TooltipBehavior? _tooltipBehavior;

  bool? isLoading;
  GetAccessToken getAccessToken = GetAccessToken();
  DrawerMenuProvider drawerMenuProvider = DrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        drawerMenuProvider.fetchGraph(1, getAccessToken.access_token);
      });
    });
  }
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("GRAPH",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                child: ChangeNotifierProvider<DrawerMenuProvider>(
                  create: (BuildContext context)=>drawerMenuProvider,
                  child: Consumer<DrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.graphData.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "General",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontFamily: Constants.OPEN_SANS,
                                                
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SfCircularChart(
                                                legend: Legend(
                                                  overflowMode: LegendItemOverflowMode.wrap,
                                                ),
                                                series: <DoughnutSeries<ChartSampleData, String>>[
                                                  DoughnutSeries<ChartSampleData, String>(
                                                    dataSource: value.graphData.data!.data.charts.general.map((item) =>
                                                        ChartSampleData(x: item.name, y: item.xmtprice, text: '')
                                                    ).toList(),
                                                    xValueMapper: (ChartSampleData data, _) =>
                                                    data.x as String,
                                                    yValueMapper: (ChartSampleData data, _) => data.y,
                                                    dataLabelMapper: (ChartSampleData data, _) =>
                                                    data.x as String,
                                                    startAngle: 270,
                                                    endAngle: 90,
                                                    dataLabelSettings: const DataLabelSettings(
                                                      isVisible: true,
                                                      labelIntersectAction: LabelIntersectAction.shift,
                                                    ),
                                                  ),
                                                ],
                                                tooltipBehavior: _tooltipBehavior,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: ListView.builder(
                                      itemCount: value.graphData.data!.data.charts.general.length,
                                      itemBuilder: (context, index){
                                        var genrtal = value.graphData.data!.data.charts.general;
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              const SizedBox(width: 10,),
                                              Text("${genrtal[index].name}  ${genrtal[index].xmtprice}",style: GraphTextStyle)
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Sub Admin",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: SfCircularChart(
                                                legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                                                series: <PieSeries<ChartSampleData, String>>[
                                                  PieSeries<ChartSampleData, String>(
                                                    explode: true,
                                                    explodeIndex: 1,
                                                    explodeOffset: '10%',
                                                    dataSource: value.graphData.data!.data.charts.subadmin.map((item) =>
                                                        ChartSampleData(x: item.name, y: item.xmtprice,text: item.name)
                                                    ).toList(),
                                                    xValueMapper: (ChartSampleData data, _) => data.x as String,
                                                    yValueMapper: (ChartSampleData data, _) => data.y,
                                                    dataLabelMapper: (ChartSampleData data, _) => data.text,
                                                    startAngle: 90,
                                                    endAngle: 90,
                                                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: ListView.builder(
                                      itemCount: value.graphData.data!.data.charts.subadmin.length,
                                      itemBuilder: (context, index){
                                        var genrtal = value.graphData.data!.data.charts.subadmin;
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              const SizedBox(width: 10,),
                                              Text("${genrtal[index].name}  ${genrtal[index].xmtprice}",style: GraphTextStyle)
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("General Finance Graph",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: SfCartesianChart(
                                                plotAreaBorderWidth: 0,
                                                primaryXAxis: CategoryAxis(
                                                  labelStyle: const TextStyle(fontSize: 12),
                                                  maximumLabels: 100,
                                                  autoScrollingDelta: 4,
                                                  majorGridLines: const MajorGridLines(width: 0),
                                                  majorTickLines: const MajorTickLines(width: 0),
                                                ),
                                                primaryYAxis: NumericAxis(
                                                  axisLine: const AxisLine(width: 0),
                                                  labelFormat: '{value}',
                                                  majorTickLines: const MajorTickLines(size: 0),
                                                  numberFormat: NumberFormat.compact()
                                                ),
                                                zoomPanBehavior: ZoomPanBehavior(enablePanning: true,),
                                                series: <ColumnSeries<ChartSampleData, String>>[
                                                  ColumnSeries<ChartSampleData, String>(
                                                    dataSource: [
                                                      ...value.graphData.data!.data.charts.generalFinanceChart.values.entries.map((currencyEntry) {
                                                        String currency = currencyEntry.key;
                                                        List<Map<String, dynamic>> values = currencyEntry.value.map((e) => e.toJson()).toList();

                                                        List<String> months = value.graphData.data!.data.charts.generalFinanceChart.months.split(',');

                                                        List<ChartSampleData> chartData = [];

                                                        for (int i = 0; i < values.length; i++) {
                                                          Map<String, dynamic> item = values[i];
                                                          String name = item["name"];
                                                          double y = item["y"].toDouble();

                                                          chartData.add(ChartSampleData(x: months[i], y: y, text: name));
                                                        }
                                                        return chartData;
                                                      }).toList(),
                                                    ].expand((x) => x).toList(),

                                                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                                                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                                                    dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                                                  ),
                                                ],
                                                tooltipBehavior: _tooltipBehavior,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Today's graph",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            /*child: Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(majorGridLines: const MajorGridLines(width: 0),),
                                      primaryYAxis: NumericAxis(
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}k',
                                          majorTickLines: const MajorTickLines(size: 0)
                                      ),
                                      series: <ColumnSeries<ChartSampleData, String>>[
                                        ColumnSeries<ChartSampleData, String>(
                                          dataSource: <ChartSampleData>[
                                            ChartSampleData(x: 'Dec', y: 100.0),
                                            ChartSampleData(x: 'Jan', y: 125.0),
                                            ChartSampleData(x: 'Feb', y: 120.0),
                                            ChartSampleData(x: 'Mar', y: 100.0),
                                            ChartSampleData(x: 'Apr', y: 116.0),
                                            ChartSampleData(x: 'May', y: 135.0),
                                            ChartSampleData(x: 'Jun', y: 179.0),
                                            ChartSampleData(x: 'Jul', y: 97.0),
                                            ChartSampleData(x: 'Aug', y: 148.0),
                                            ChartSampleData(x: 'Sep', y: 242.0),
                                            ChartSampleData(x: 'Oct', y: 222.0),
                                            ChartSampleData(x: 'Nav', y: 84.0),
                                          ],
                                          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                                          yValueMapper: (ChartSampleData sales, _) => sales.y,
                                          dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                                        )
                                      ],
                                      tooltipBehavior: _tooltipBehavior,
                                    ),
                                  ),*/
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    /*child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.indigo,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("Completed  309.0",style: GraphTextStyle)
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.brown,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("Cancel  6.0",style: GraphTextStyle)
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.redAccent,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("Process  51.0",style: GraphTextStyle)
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.orangeAccent,
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("Hold  2.0",style: GraphTextStyle)
                                  ],
                                ),
                              ],
                            ),
                          ),*/
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Monthly Graph",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: SfCartesianChart(
                                                plotAreaBorderWidth: 0,
                                                primaryXAxis: CategoryAxis(
                                                  labelStyle: const TextStyle(fontSize: 12),
                                                  maximumLabels: 100,
                                                  autoScrollingDelta: 4,
                                                  majorGridLines: const MajorGridLines(width: 0),
                                                  majorTickLines: const MajorTickLines(width: 0),
                                                ),
                                                primaryYAxis: NumericAxis(
                                                  axisLine: const AxisLine(width: 0),
                                                  labelFormat: '{value}',
                                                  majorTickLines: const MajorTickLines(size: 0),
                                                  numberFormat: NumberFormat.compact(),
                                                  labelAlignment: LabelAlignment.end
                                                ),
                                                zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                                                series: <ColumnSeries<ChartSampleData, String>>[
                                                  ColumnSeries<ChartSampleData, String>(
                                                    dataSource: value.graphData.data!.data.charts.monthlyGraph.inr
                                                        .map((data) => ChartSampleData(x: data.dt.toString(), y: data.y, text: ''))
                                                        .toList(),
                                                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                                                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                                                    dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 8)),
                                                  ),
                                                ],
                                                tooltipBehavior: _tooltipBehavior,
                                              )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Graph",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: SfCircularChart(
                                                tooltipBehavior: TooltipBehavior(enable: true),
                                                legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                                                series: <DoughnutSeries<ChartSampleData, String>>[
                                                  DoughnutSeries<ChartSampleData, String>(
                                                      radius: '100%',
                                                      explode: true,
                                                      explodeIndex: 1,
                                                      explodeOffset: '20%',
                                                      dataSource: value.graphData.data!.data.charts.mainGraph.map((item) =>
                                                          ChartSampleData(x: item.name, y: item.xmtprice,text: item.name)
                                                      ).toList(),
                                                      xValueMapper: (ChartSampleData data, _) => data.x as String,
                                                      yValueMapper: (ChartSampleData data, _) => data.y,
                                                      dataLabelMapper: (ChartSampleData data, _) => data.text,
                                                      dataLabelSettings: const DataLabelSettings(isVisible: true)
                                                  )
                                                ],
                                                onTooltipRender: (TooltipArgs args) {
                                                  final NumberFormat format = NumberFormat.decimalPattern();
                                                  args.text = '${args.dataPoints![args.pointIndex!.toInt()].x} : ${format.format(args.dataPoints![args.pointIndex!.toInt()].y)}';
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: ListView.builder(
                                      itemCount: value.graphData.data!.data.charts.mainGraph.length,
                                      itemBuilder: (context, index){
                                        var mainGraph = value.graphData.data!.data.charts.mainGraph;
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              const SizedBox(width: 10,),
                                              Expanded(child: Text("${mainGraph[index].name}  ${mainGraph[index].xmtprice}",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS)))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                speed: 500,
                                onFlipDone: (status) {
                                  print(status);
                                },
                                front: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: PrimaryColorOne,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Graph",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 4.5,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              child: SfCircularChart(
                                                tooltipBehavior: TooltipBehavior(enable: true),
                                                legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                                                series: <DoughnutSeries<ChartSampleData, String>>[
                                                  DoughnutSeries<ChartSampleData, String>(
                                                      radius: '100%',
                                                      explode: true,
                                                      explodeIndex: 1,
                                                      explodeOffset: '20%',
                                                      dataSource: value.graphData.data!.data.charts.mainGraph1.map((item) =>
                                                          ChartSampleData(x: item.name, y: item.xmtprice,text: item.name)
                                                      ).toList(),
                                                      xValueMapper: (ChartSampleData data, _) => data.x as String,
                                                      yValueMapper: (ChartSampleData data, _) => data.y,
                                                      dataLabelMapper: (ChartSampleData data, _) => data.text,
                                                      dataLabelSettings: const DataLabelSettings(isVisible: true)
                                                  )
                                                ],
                                                onTooltipRender: (TooltipArgs args) {
                                                  final NumberFormat format = NumberFormat.decimalPattern();
                                                  args.text = '${args.dataPoints![args.pointIndex!.toInt()].x} : ${format.format(args.dataPoints![args.pointIndex!.toInt()].y)}';
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                back: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                                    ),
                                    child: ListView.builder(
                                      itemCount: value.graphData.data!.data.charts.mainGraph1.length,
                                      itemBuilder: (context, index){
                                        var mainGraph1 = value.graphData.data!.data.charts.mainGraph1;
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 8,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              const SizedBox(width: 10,),
                                              Expanded(child: Text("${mainGraph1[index].name}  ${mainGraph1[index].xmtprice}",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS)))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ChartSampleData {
  ChartSampleData({
    this.x,
    required this.y,
    required this.text,
  });
  final dynamic x;
  final num y;
  final String text;
}
class Value {
  final double y;
  final String name;

  Value({required this.y, required this.name});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      y: json['y'].toDouble(),
      name: json['name'],
    );
  }
}