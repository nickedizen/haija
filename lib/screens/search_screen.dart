import 'package:final_project_haija/services/appuser_service.dart';
import 'package:final_project_haija/widgets/custom_appbar.dart';
import 'package:final_project_haija/widgets/query_user_view.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hasil pencarian untuk $query'),
            const SizedBox(height: 10),
            const Text(
              'User',
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 10),
            QueryUserView(function: AppUserService.getUsersByUsername(query)),
            const SizedBox(height: 10),
            const Text(
              'Books',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}