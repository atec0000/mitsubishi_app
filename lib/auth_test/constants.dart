// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const TCP_ADDRESS = 'tecoserver.com';
const TCP_PORT = 8750;

const LOGIN_SINUP = '登入/註冊帳號';
const EMAIL = '電子信箱';

const List<int> allStatus = [0x06,0x00,0x08,0xff,0xff,0x0e];

const List<int> AC_POWER_ON = [0x06, 0x01, 0x80, 0x00, 0x01, 0x86];
const List<int> AC_POWER_OFF = [0x06, 0x01, 0x80, 0x00, 0x00, 0x87];

const List<int> AC_MODE_AUTO = [0x06, 0x01, 0x81, 0x00, 0x03, 0x85];
const List<int> AC_MODE_COOL = [0x06, 0x01, 0x81, 0x00, 0x00, 0x86];
const List<int> AC_MODE_HUMI = [0x06, 0x01, 0x81, 0x00, 0x01, 0x87];
const List<int> AC_MODE_FAN = [0x06, 0x01, 0x81, 0x00, 0x02, 0x84];
const List<int> AC_MODE_HEAT = [0x06, 0x01, 0x81, 0x00, 0x04, 0x82];

const List<int> AC_GET_TEMP = [0x06, 0x01, 0x03, 0xff, 0xff, 0x04];
const List<int> AC_GET_POWER = [0x06, 0x01, 0x00, 0xff, 0xff, 0x07];
const List<int> AC_GET_MODE = [0x06, 0x01, 0x01, 0xff, 0xff, 0x06];

const List<int> LIGHT_POWER_ON = [0x06, 0x11, 0x80, 0x00, 0x01, 0x96];
const List<int> LIGHT_POWER_OFF = [0x06, 0x11, 0x80, 0x00, 0x00, 0x97];

const List<int> LIGHT_GET_POWER = [0x06, 0x11, 0x00, 0xff, 0xff, 0x17];
const List<int> LIGHT_GET_BRIGHT = [0x06, 0x11, 0x01, 0xff, 0xff, 0x16];
const List<int> LIGHT_GET_COLOR = [0x06, 0x11, 0x02, 0xff, 0xff, 0x15];

const backgroundColor = Color(0xfff1f6f9);
const buttonColor = Color(0xff14274e);
const color1 = Color(0xfffe9200);
const color0 = Color(0x40fe9200);
const color2 = Color(0xff3e51b5);
const color3 = Color(0xff394867);
const color4 = Color(0xff9ba4b4);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
