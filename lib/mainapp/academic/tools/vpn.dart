import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:xmux/globals.dart';

class VPNPage extends StatefulWidget {
  @override
  _VPNPageState createState() => _VPNPageState();
}

class _VPNPageState extends State<VPNPage> {
  var currentState = FlutterVpnState.down;
  StreamSubscription subscription;

  Color get color {
    switch (currentState) {
      case FlutterVpnState.down:
        return Colors.black54;
      case FlutterVpnState.up:
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  @override
  void initState() {
    FlutterVpn.prepare();
    subscription = FlutterVpn.onStateChanged
        .listen((s) => setState(() => currentState = s));
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: 'res/academic/vpn.svg',
              child: SvgPicture.asset(
                'res/academic/vpn.svg',
                height: 66.0,
                width: 66.0,
                color: color,
              ),
            ),
          ),
          Text(
            '''
The VPN access is limited for academic and research purposes only.
The VPN allows remote access to the ‘Library E-Resources and Academic Database’ of the Main Library of XMU, China. Academic users need to access the library database through academic VPN.    
          ''',
            textAlign: TextAlign.center,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => FlutterVpn.simpleConnect(
                        'ikev2.xmu.edu.my',
                        firebaseUser.uid,
                        store.state.authState.campusIDPassword),
                    child: Text('Connect'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => FlutterVpn.disconnect(),
                    child: Text('Disconnect'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
