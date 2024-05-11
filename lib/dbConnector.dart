// import 'package:mysql_client/mysql_client.dart';0
//
// Future<MySqlConnection> dbConnector() async {
//   print("Connecting to MySQL server...");
//
//   // MySQL 접속 설정
//   final settings = ConnectionSettings(
//     host: 'your_mysql_host',
//     port: 3306,
//     user: 'your_mysql_user',
//     password: 'your_mysql_password',
//     db: 'your_mysql_database',
//   );
//
//   final conn = await MySqlConnection.connect(settings);
//
//   print("Connected");
//
//   return conn;
// }
//
// Future<void> main() async {
//   final conn = await dbConnector();
//
//   // 예시 쿼리 실행
//   Results results = await conn.query('select * from your_table');
//   for (var row in results) {
//     print('Row: $row');
//   }
//
//   await conn.close();
// }