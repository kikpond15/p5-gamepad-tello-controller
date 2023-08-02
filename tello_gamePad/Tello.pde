class Tello {
  
  String mes_x, mes_y, mes_updown, mes_yaw;
  Tello() {
    mes_x = mes_y = mes_updown = mes_yaw = "0";
  }

  void rcMove(int x, int y, int upDown, int yaw, int speed) {
    if (x == 0) mes_x = "0";
    else if (x == 1) mes_x = str(speed);
    else if (x == -1) mes_x = "-"+str(speed);
    
    if (y == 0) mes_y = "0";
    else if (y == 1) mes_y = str(speed);
    else if (y == -1) mes_y = "-"+str(speed);
    
    if (upDown == 0) mes_updown = "0";
    else if (upDown == 1) mes_updown = str(speed);
    else if (upDown == -1) mes_updown = "-"+str(speed);
    
    if (yaw == 0) mes_yaw = "0";
    else if (yaw == 1) mes_yaw = str(speed);
    else if (yaw == -1) mes_yaw = "-"+str(speed);
    
    String rc_mes = "rc" + " "+mes_x + " "+mes_y + " "+mes_updown + " "+mes_yaw;
    udp.send(rc_mes, ip, port);
  }

  void tekeoff() {
    udp.send("takeoff", ip, port);
    sleep(2, "Takeoff");
  }

  void land() {
    udp.send("land", ip, port);
    sleep(2, "Land");
  }

  void receive( byte[] data, String ip, int port ) {
    String message = new String( data );
    println( "receive: \""+message+"\" from "+ip+" on port "+port );
  }

  void sleep(int sec, String mes) {
    int timer = second()+sec;
    println(mes + " Count:" + sec);
    while (timer > second()) {
    }
  }
}
