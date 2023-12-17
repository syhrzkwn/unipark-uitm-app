import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deleting account', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(10.0),
                Text('By deleting your UniPark@UiTM Account, you aware and agree to these following conditions:', style: Theme.of(context).textTheme.titleSmall),
                const Gap(10.0),
                ListTile(
                  leading: const Icon(Icons.error, color: Colors.orange),
                  title: Text("Account can't be reinstated.", style: Theme.of(context).textTheme.titleSmall),
                ),
                ListTile(
                  leading: const Icon(Icons.error, color: Colors.orange),
                  title: Text("All data linked to the account will be deleted according to UniPark@UiTM.", style: Theme.of(context).textTheme.titleSmall),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.deleteUserAccount(),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
