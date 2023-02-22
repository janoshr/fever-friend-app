import 'package:fever_friend_app/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../l10n/app_localizations.dart';
import '../services/firestore.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _error;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loc.settings),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_error != null) ...[
                  Text(
                    _error!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                ],
                FormBuilderDropdown(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text(loc.lang),
                    prefixIcon: const Icon(Icons.language),
                  ),
                  name: 'lang',
                  validator: FormBuilderValidators.required(),
                  items: [
                    DropdownMenuItem(value: 'en', child: Text(loc.en)),
                    DropdownMenuItem(value: 'hu', child: Text(loc.hu)),
                  ],
                ),
                const SizedBox(height: 12),
                FormBuilderCheckbox(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    label: Text(loc.participateInResearch),
                  ),
                  name: 'research',
                  title: Text(loc.participateInResearchDetails),
                ),
                const SizedBox(height: 12),
                //const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => onSubmit(context, () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }),
                  child: Text(loc.saveSettings),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onSubmit(BuildContext context, VoidCallback onSuccess) async {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.validate();

    if (_formKey.currentState!.isValid) {
      final db = getIt.get<FirestoreService>();
      final fields = _formKey.currentState!.fields;

      try {
        // TODO: save user settings
        onSuccess.call();
      } catch (e) {
        debugPrint(e.toString());
        _error = 'Something went wrong';
      }
    }
  }
}
