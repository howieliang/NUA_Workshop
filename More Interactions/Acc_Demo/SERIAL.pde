void getSerialMsg() {
  int i = 0;
  int data = 0;
  while ( port.available () > 0) {
    data = (int)port.read();
    if (i < data_Num) {
      serialData[i] = data;
      i++;
    } else {
      i = data_Num;
      break;
    }
  }
  if (i == data_Num) {
    //printSerial();
    port.clear();
    port.write('a');
  }
}

void printSerial() {
  //println(serialData[0], serialData[1], serialData[2]);
}