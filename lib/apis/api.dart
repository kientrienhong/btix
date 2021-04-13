import 'package:dio/dio.dart';

class Api {
  Api();

  static Future<List<dynamic>> fetchAllFilm() async {
    final response = await Dio().get(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP10');
    return response.data;
  }

  static Future<List<dynamic>> fetchAllTheatreBrand() async {
    final response = await Dio().get(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyRap/LayThongTinHeThongRap');
    return response.data;
  }

  static Future<List<dynamic>> fetchAllTheatreBrandVia(String idTheatre) async {
    final reponse = await Dio().get(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyRap/LayThongTinLichChieuHeThongRap?maHeThongRap=$idTheatre&maNhom=GP10');
    return reponse.data;
  }

  static Future<Map<String, dynamic>> fetchAllSeat(String idSchedule) async {
    final reponse = await Dio().get(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyDatVe/LayDanhSachPhongVe?MaLichChieu=$idSchedule');
    return reponse.data;
  }
}
