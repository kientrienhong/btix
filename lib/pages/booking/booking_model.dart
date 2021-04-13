import 'package:btix/models/room.dart';
import 'package:btix/models/schedule.dart';
import 'package:btix/models/seat.dart';

class BookingModel {
  final Schedule currentSchedule;
  final Room currentRoom;
  final Map<String, List<Schedule>> listGroupSchedule;
  final List<String> listDate;
  final bool isLoading;
  final List<Seat> selectedSeat;
  final List<Map<String, dynamic>> listTime;
  BookingModel(
      {this.listDate,
      this.selectedSeat,
      this.isLoading: false,
      this.listTime,
      this.currentSchedule,
      this.currentRoom,
      this.listGroupSchedule});

  BookingModel copyWith(
      {List<String> listDate,
      bool isLoading,
      List<Seat> selectedSeat,
      Schedule currentSchedule,
      Room currentRoom,
      List<Map<String, dynamic>> listTime,
      Map<String, List<Schedule>> listGroupSchedule}) {
    return BookingModel(
        selectedSeat: selectedSeat ?? this.selectedSeat,
        isLoading: isLoading ?? this.isLoading,
        listTime: listTime ?? this.listTime,
        listDate: listDate ?? this.listDate,
        currentRoom: currentRoom ?? this.currentRoom,
        currentSchedule: currentSchedule ?? this.currentSchedule,
        listGroupSchedule: listGroupSchedule ?? this.listGroupSchedule);
  }
}
