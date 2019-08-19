import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportEvent extends Equatable {
  ReportEvent([List props = const []]) : super(props);
}

class LoadReports extends ReportEvent {
  @override
  String toString() => 'Load Reports';
}

class LoadReportsByPlayer extends ReportEvent {
  final Player player;

  LoadReportsByPlayer(this.player) : super([player]);
}

class AddReport extends ReportEvent {
  final Report insertReport;

  AddReport(this.insertReport) : super([insertReport]);
  @override
  String toString() => 'Add Report';
}

class UpdateWithReport extends ReportEvent {
  final Report updatedReport;

  UpdateWithReport(this.updatedReport) : super([updatedReport]);
  @override
  String toString() => 'Update WithReport';
}

class DeleteReport extends ReportEvent {
  final Report report;

  DeleteReport(this.report) : super([report]);
  @override
  String toString() => 'Delete Report';
}
