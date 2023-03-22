part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class GetScheduleEvent extends ScheduleEvent {}

class AddScheduleEvent extends ScheduleEvent {
  final String bus;
  final String road;
  final int cost;
  final String startTime;
  final String endTime;

  AddScheduleEvent(this.bus, this.road, this.cost, this.startTime, this.endTime);
}

class DeleteScheduleEvent extends ScheduleEvent {
  final Schedule schedule;

  DeleteScheduleEvent(this.schedule);
}
