import 'package:Wellness/model/report.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReportState extends Equatable {
  ReportState([List props = const []]) : super(props);
}

class InitialReportState extends ReportState {
  @override
  String toString() => 'Initial ReportState';
}

class ReportsLoading extends ReportState {
  @override
  String toString() => 'Reports Loading';
}

class ReportsLoaded extends ReportState {
  final List<Report> reports;

  ReportsLoaded(this.reports) : super([reports]);
  @override
  String toString() => 'Reports Loaded';
}
