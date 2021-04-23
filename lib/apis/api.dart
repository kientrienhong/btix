import 'package:btix/models/user.dart';
import 'package:btix/services/auth.dart';
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

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final reponse = await Dio().post(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/DangNhap',
        data: {'taiKhoan': email, 'matKhau': password});
    return reponse.data;
  }

  static Future<Map<String, dynamic>> signUp(
      String email, String password) async {
    final reponse = await Dio().post(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/DangKy',
        data: {
          'taiKhoan': email,
          'matKhau': password,
          'email': email,
          'soDT': '',
          'maNhom': 'GP10',
          'maLoaiNguoiDung': 'KhacHang',
          'hoTen': email
        });
    return reponse.data;
  }

  static Future<Map<String, dynamic>> checkOut(
      String idSchedule,
      List<Map<String, num>> listSelectedSeat,
      String username,
      String accessToken) async {
    final response = await Dio(BaseOptions(headers: {
      'Authorization': 'Bearer ' + accessToken,
    })).post('https://movie0706.cybersoft.edu.vn/api/QuanLyDatVe/DatVe', data: {
      "maLichChieu": int.parse(idSchedule),
      "danhSachVe": listSelectedSeat,
      "taiKhoanNguoiDung": username
    });

    return response.data;
  }

  static Future<Map<String, dynamic>> getAccountInfo(String username) async {
    final response = await Dio().post(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/ThongTinTaiKhoan',
        data: {
          'taiKhoan': username,
        });

    return response.data;
  }

  static Future<Map<String, dynamic>> updateAccountInfo(User user,
      {String password}) async {
    final userInfo = await getAccountInfo(user.username);
    final response = await Dio(BaseOptions(headers: {
      'Authorization': 'Bearer ' + user.accessToken,
    })).put(
        'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/CapNhatThongTinNguoiDung',
        data: {
          "taiKhoan": user.username,
          'matKhau': password == null ? userInfo['matKhau'] : password,
          "email": user.email,
          "soDt": user.phone,
          "maNhom": 'GP10',
          "maLoaiNguoiDung": 'KhachHang',
          "hoTen": user.name
        });

    print(password);
    return response.data;
  }
}
