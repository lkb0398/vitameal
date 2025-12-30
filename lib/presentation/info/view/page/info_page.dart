import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitameal/presentation/info/view/widget/view_goal.dart';
import 'package:vitameal/presentation/info/view/widget/view_info.dart';
import 'package:vitameal/presentation/home/view/widget/custom_appbar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('my userId : 🩷 ${Supabase.instance.client.auth.currentUser!.id}');

    return Column(
      children: [
        /// appBar
        CustomAppBar(
          title: Text("내 정보", style: TextStyle(fontSize: 20)),
          actions: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/setting');
            },
          ),
        ),

        /// body
        Expanded(
          child: SingleChildScrollView(
            child: Column(spacing: 20, children: [ViewInfo(), ViewGoal()]),
          ),
        ),
      ],
    );
  }
}
