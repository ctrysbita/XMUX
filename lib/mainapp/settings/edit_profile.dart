import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:xmux/generated/i18n.dart';
import 'package:xmux/globals.dart';
import 'package:xmux/redux/state/state.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _displayNameController =
      TextEditingController(text: firebaseUser?.displayName ?? 'User');

  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() async {
    if (!_formKey.currentState.validate()) return;
    firebaseUser.updateProfile(
        UserUpdateInfo()..displayName = _displayNameController.text);
    firebaseUser.reload();
    firebaseUser = await FirebaseAuth.instance.currentUser();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Settings_UpdateProfile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _handleSubmit,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Hero(
                    tag: 'UserAvatar',
                    child: StoreConnector<MainAppState, String>(
                      converter: (s) => s.state.user.profile?.avatar ?? '',
                      builder: (context, s) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          '/Components/ImageEditor',
                          arguments: ExtendedNetworkImageProvider(s),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(s),
                          radius: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                StoreConnector<MainAppState, String>(
                  converter: (s) => s.state.user.profile?.displayName ?? 'User',
                  builder: (context, s) => Text(s),
                ),
              ],
            ),
            Text(
              i18n('Settings/ChangeProfile/Caption', context),
              style: Theme.of(context).textTheme.caption,
            ),
            TextFormField(
              controller: _displayNameController,
              decoration: InputDecoration(
                  labelText:
                      i18n('Settings/ChangeProfile/DisplayName', context)),
              maxLength: 25,
              validator: (name) => name.isNotEmpty ? null : 'Format error',
            ),
          ],
        ),
      ),
    );
  }
}
