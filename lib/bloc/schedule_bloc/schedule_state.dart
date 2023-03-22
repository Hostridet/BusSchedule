part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadingState extends ScheduleState {}

class ScheduleLoadedState extends ScheduleState {
  final List<Schedule> scheduleList;
  final List<Road> roadList;
  final List<Bus> busList;

  ScheduleLoadedState(this.scheduleList, this.roadList, this.busList);
}
class ScheduleErrorState extends ScheduleState {
  final String error;

  ScheduleErrorState(this.error);
}