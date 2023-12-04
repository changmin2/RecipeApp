import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//애뮬레이터 로컬
final emulatorIp = '10.0.2.2:8081';
//시뮬레이터 로컬
final simulatorIp = '127.0.0.1:8081';
//아이폰일 경우 시뮬레이터 아이피 아닐 경우 애뮬레이터 아이피
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
//final ip = '43.200.42.112:8888';