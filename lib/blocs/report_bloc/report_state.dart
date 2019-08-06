import 'package:Wellness/model/report.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportState extends Equatable {
  ReportState([List props = const []]) : super(props);
}

class InitialReportState extends ReportState {}

class ReportsLoading extends ReportState {}

class ReportsLoaded extends ReportState {
  final List<Report> players;

  ReportsLoaded(this.players) : super([players]);
}
