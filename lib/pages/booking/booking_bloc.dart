import 'package:btix/apis/api.dart';
import 'package:btix/models/room.dart';
import 'package:btix/models/schedule.dart';
import 'package:btix/models/seat.dart';
import 'package:btix/models/theatre.dart';
import 'package:btix/pages/booking/booking_model.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class BookingBloc {
  final _controller = PublishSubject<BookingModel>();
  BookingModel _model = BookingModel();

  Stream<BookingModel> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void updateWith(
      {Room room,
      bool isLoading,
      List<Seat> selectedSeat,
      Schedule currentSchedule,
      Map<String, List<Schedule>> listGroupSchedule,
      List<String> listDate,
      List<Map<String, dynamic>> listTime}) {
    _model = _model.copyWith(
        selectedSeat: selectedSeat,
        isLoading: isLoading,
        listDate: listDate,
        listGroupSchedule: listGroupSchedule,
        listTime: listTime,
        currentRoom: room,
        currentSchedule: currentSchedule);
    _controller.add(_model);
  }

  void updateTheatre({Theatre theatre}) {
    final groups = groupBy(theatre.film.listSchedule, (Schedule e) {
      return e.date;
    });

    List<String> listKey = groups.keys.toList();

    List<Map<String, dynamic>> listTime = [];
    groups[listKey[0]]
        .forEach((e) => listTime.add({'time': e.time, 'scheduleId': e.id}));
    updateWith(
      listDate: listKey,
      listGroupSchedule: groups,
      listTime: listTime,
      currentSchedule: theatre.film.listSchedule[0],
    );
  }

  void selectedSeat({String seatId, StatusSeat statusSeat}) {
    if (statusSeat == StatusSeat.sold) {
      return;
    }
    Room room = _model.currentRoom;
    List<Seat> selectedListSeat = _model.selectedSeat;
    List<Seat> currentRoomSeatList = room.seatList;
    int indexSeat =
        currentRoomSeatList.indexWhere((element) => element.id == seatId);
    Seat seat = currentRoomSeatList[indexSeat];
    if (statusSeat == StatusSeat.selected) {
      selectedListSeat.removeWhere((element) => element.id == seatId);
      currentRoomSeatList[indexSeat] =
          seat.copyWith(statusSeat: StatusSeat.available);
    } else {
      int noSeat = int.parse(seat.no);
      int remain = noSeat % 10;
      noSeat = (noSeat / 10).round();
      String alphabetAscii = String.fromCharCode(noSeat + 65);
      seat = seat.copyWith(
          statusSeat: StatusSeat.selected,
          name: alphabetAscii + remain.toString());
      selectedListSeat.add(seat);

      currentRoomSeatList[indexSeat] = seat;
    }
    // selectedListSeat.fold(0, (previousValue, element) => previousValue + element.price)
    room = room.copyWith(seatList: currentRoomSeatList);

    updateWith(selectedSeat: selectedListSeat, room: room);
  }

  void changeDate(int index) {
    final currentDate = _model.listDate[index];
    List<Map<String, dynamic>> listTime = [];
    _model.listGroupSchedule[currentDate].forEach((element) =>
        listTime.add({'time': element.time, 'scheduleId': element.id}));
    Schedule currentSchedule = _model.listGroupSchedule[currentDate][0];
    updateWith(listTime: listTime, currentSchedule: currentSchedule);
    fetchSeat();
  }

  void changeTime(String scheduleId) {
    Schedule currentSchedule = _model
        .listGroupSchedule[_model.currentSchedule.date]
        .firstWhere((element) => element.id == scheduleId);

    updateWith(currentSchedule: currentSchedule);
    fetchSeat();
  }

  void fetchSeat() async {
    updateWith(isLoading: true);
    Map<String, dynamic> reponse =
        await Api.fetchAllSeat(_model.currentSchedule.id);
    List<dynamic> seatList = reponse['danhSachGhe'];
    List<Seat> seatListResult = [];
    seatList.forEach((element) {
      seatListResult.add(Seat.fromJson(element));
    });
    Room room = Room.fromJson(reponse, seatListResult);
    updateWith(room: room, isLoading: false, selectedSeat: <Seat>[]);
  }
}
