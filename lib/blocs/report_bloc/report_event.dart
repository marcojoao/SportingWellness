import 'package:Wellness/model/player.dart';
import 'package:Wellness/model/report.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportEvent extends Equatable {
  ReportEvent([List props = const []]) : super(props);
}

class LoadReports extends ReportEvent {}

class LoadReportsByPlayer extends ReportEvent {
  final Player player;

  LoadReportsByPlayer(this.player) : super([player]);
}

class AddReport extends ReportEvent {
  final Report insertReport;

  AddReport(this.insertReport) : super([insertReport]);
}

class UpdateWithReport extends ReportEvent {
  final Report updatedReport;

  UpdateWithReport(this.updatedReport) : super([updatedReport]);
}

class DeleteReport extends ReportEvent {
  final Report report;

  DeleteReport(this.report) : super([report]);
}
