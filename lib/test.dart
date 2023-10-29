import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('ID: ${data['id']}, Title: ${data['title']}');
  } else {
    print('Failed to load data: ${response.statusCode}');
  }
}
