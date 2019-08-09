import 'package:Wellness/blocs/report_bloc/bloc.dart';
import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:Wellness/services/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerCartesianChart extends StatefulWidget {
  Player player;
  DateTime date;

  PlayerCartesianChart(this.player, this.date);

  _PlayerCartesianChartState createState() => _PlayerCartesianChartState();
}

class _PlayerCartesianChartState extends State<PlayerCartesianChart> {
  ReportBloc _reportBloc;

  @override
  void initState() {
    super.initState();

    _reportBloc = BlocProvider.of<ReportBloc>(context);
    //PlayerCartesianChart( this.widget.player , this.widget.date);

    _reportBloc.dispatch(LoadReports());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _reportBloc,
        builder: (BuildContext context, ReportState state) {
          if (state is ReportsLoading) {
            return Container(
              child: SizedBox(
                child: new CircularProgressIndicator(strokeWidth: 5.0),
                height: 50.0,
                width: 50.0,
              ),
            );
          } else if (state is ReportsLoaded) {
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 20,
                  minimum: -20,
                  maximum: 120,
                  visibleMinimum: 0,
                  visibleMaximum: 100,
                  rangePadding: ChartRangePadding.additional,
                  labelFormat: '{value}%'),
              title: ChartTitle(
                  text:
                      "${AppLoc.getValue('recoveryOver')} ${DateFormat('MMMM').format(widget.date)}"),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <LineSeries<Report, String>>[
                LineSeries<Report, String>(
                  name: AppLoc.getValue('recovery'),
                  color: Theme.of(context).accentColor,
                  dataSource: state.reports,
                  xValueMapper: (Report report, _) =>
                      report.dateTime.day.toString(),
                  yValueMapper: (Report report, _) => report.recovery,
                  markerSettings:
                      MarkerSettings(color: Colors.white, isVisible: true),
                )
              ],
            );
          } else {
            return Text("PlayerCartesianChart");
          }
        });
  }
}
