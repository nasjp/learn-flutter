import 'dart:io';

Future main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print("run serve => ${server.address}:${server.port}");
  await for (var request in server) {
    request.response
      ..headers.contentType =
          ContentType("application", "json", charset: "utf-8")
      ..write({'user': 'nas', 'age': 25})
      ..close();
  }
}
