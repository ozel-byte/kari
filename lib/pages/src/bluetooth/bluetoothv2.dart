import 'dart:convert';

import 'dart:typed_data';

import 'package:bioappmikary/pages/src/bluetooth/datosUltimos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothExistUser extends StatefulWidget {
  final Map<String, dynamic>? user;
  const BluetoothExistUser({Key? key, this.user}) : super(key: key);

  @override
  State<BluetoothExistUser> createState() => _PageBlueState();
}

class _PageBlueState extends State<BluetoothExistUser> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _deviceList = [];

  var connection;

  bool get isConnected => connection != null && connection.isConnected;

  var _deviceState;
  var _device;
  bool _isButtonUnavaible = false;
  String vozText = "";
  String value = "";
  String rango = "";
  int posicionListActiveConected = 0;
  bool activeSenal = false;
  bool activeConnectNone = false;
  String nombreDispositivoConectado = "";
  String direcionDispositivoConectado = "";
  String status = "...";
  List<String> numeros = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0;

    enabledBluetooth();

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        getPairedDevices();
      });
    });
  }

  Future<bool> enabledBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await _bluetoothSerial.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _deviceList = devices;
    });
  }

  bool isDisconnecting = false;

  bool _connected = false;
  final ref = FirebaseFirestore.instance.collection("Paciente");
  final ref_cita = FirebaseFirestore.instance.collection("Cita");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              FlutterBluetoothSerial.instance.requestDisable();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Encender bluetooth",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Switch(
              activeColor: Colors.blue,
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value) {
                    await FlutterBluetoothSerial.instance.requestEnable();
                  } else {
                    await FlutterBluetoothSerial.instance.requestDisable();
                  }

                  await getPairedDevices();
                  _isButtonUnavaible = false;

                  if (_connected) {
                    _disconnec();
                  }
                }

                future().then((_) => {setState(() {})});
              }),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Lista de dispositivos",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            width: size.width * 1,
            height: size.height * 0.4,
            child: listDeviceActive(size),
          ),
          Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ROM: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text(rango,style: TextStyle(color: Colors.green),)
                  ],
                ),
                Text(value,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (value != " ") {
            await FlutterBluetoothSerial.instance.requestDisable();
            if (mounted) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return HomeDataLast(
                    value: {
                      "id": widget.user!["id"],
                      "data": widget.user!["data"],
                      "tamaño": value,
                    },
                  );
                },
              ));
            }
          }
        },
        child: Icon(Icons.send_and_archive_rounded),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_deviceList.isEmpty) {
      items.add(DropdownMenuItem(child: Text('NONE')));
    } else {
      _deviceList.forEach((element) {
        items.add(DropdownMenuItem(
          child: Text(element.name!),
          value: element,
        ));
      });
    }
    return items;
  }

  Future ttop() async {}

  void _connect() async {
    if (_device == null) {
      print("dispositivo no select");
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print("Connected to the device");
          connection = _connection;

          setState(() {
            _connected = true;
          });
          int index = 0;
          bool aux = false;
          List auxtext = [];
          connection.input!.listen((Uint8List data) {
            
            String s = String.fromCharCodes(data).trim();
            print(s);
            if (s.length == 1) {
              
              numeros.add(s);
              if (numeros.length == 2) {
                print("2 numeros");
                setState(() {
                  value = numeros[0] + numeros[1];
                });
                
                numeros.clear();
              }else{
              aux=true;
              }
            }
            else if (s.length == 2) {
              setState(() {
                value = s;
              });
              
            } else if (s.length == 3) {
              setState(() {
                value=s;
              });
              
            } else {
              setState(() {});
              value = "";
            }

            if (s.length==2 && numeros.length==1) {
              setState(() {
                numeros.add(s);
                value = numeros[0] + numeros[1];
                
                
              });
              numeros.clear();
            }
            
            index += 1;
          }).onDone(() {
            if (isDisconnecting) {
              print("Disconnecting locally!");
            } else {
              print("Disconnecyed remotely!");
            }

            if (this.mounted) {
              setState(() {});
            }
          });
        });
      }
    }
  }

  Widget listDeviceActive(Size size) {
    if (_deviceList.isEmpty) {
      return Center(
        child: Text("None"),
      );
    } else {
      return !activeConnectNone
          ? ListView.builder(
              itemCount: _deviceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_deviceList[index].name!),
                  subtitle: Text(_deviceList[index].address),
                  trailing: TextButton(
                      onPressed: () {
                        _device = _deviceList[index];
                        nombreDispositivoConectado = _deviceList[index].name!;
                        direcionDispositivoConectado =
                            _deviceList[index].address;
                        _isButtonUnavaible
                            ? null
                            : _connected
                                ? _disconnec()
                                : _connect();
                        activeConnectNone = true;
                        setState(() {});
                      },
                      child: Text(_connected ? 'Disconnect' : 'Connect')),
                );
              },
            )
          : Container(
              width: size.width * 1,
              height: size.height * 1,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Conectado",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                  ),
                  Text(nombreDispositivoConectado),
                  Text(direcionDispositivoConectado)
                ],
              )),
            );
    }
  }

  void received() {
    connection.input.listen((Uint8List data) {
      print(ascii.decode(data));
    });
  }

  void _disconnec() async {
    await connection.close();

    if (!connection.isConnected) {
      setState(() {
        _connected = false;
      });
    }
  }

  void _sendOnMessageToBluetooth() async {
    connection.output.add(Utf8Encoder().convert('1'));
    await connection.output.allSent;
    setState(() {
      _deviceState = 1;
    });
  }

  void _sendOffMessageToBluetooth() async {
    connection.output.add(Utf8Encoder().convert('0'));
    await connection.output.allSent;
    setState(() {
      _deviceState = -1;
    });
  }
}
