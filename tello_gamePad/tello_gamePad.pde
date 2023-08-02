import org.gamecontrolplus.*;
import hypermedia.net.*;


ControlIO control;
ControlDevice device;
UDP udp;
Tello tello;
PSCon pscon;

String ip = "192.168.10.1";
int port = 8889;
boolean isTakeoff = false;
int speed = 30;

void setup() {
  size(640, 480);
  control = ControlIO.getInstance(this);
  println(": " + control.getDevices());
  device = control.getDevice("Wireless Controller");
  udp = new UDP(this, port);
  udp.listen(true);
  udp.send("command", ip, port);

  pscon = new PSCon();
  tello = new Tello();
  textSize(50);
}


void draw() {
  background(0);
  pscon.updateButtons();
  pscon.updateSliders();
  pscon.drawController();

  if (pscon.isPressedButton(pscon.lmB)) {
    isTakeoff = true;
    tello.tekeoff();
  } else if (pscon.isPressedButton(pscon.rmB)) {
    isTakeoff = false;
    tello.land();
  }
  if (pscon.isPressedButton(pscon.upB)) speed += 10;
  else if (pscon.isPressedButton(pscon.downB)) speed -= 10;
  speed = constrain(speed, 10, 100);

  float threshold = 0.3;
  int x = int(constrain(map(pscon.joyL.x, -threshold, threshold, 1, -1), -1, 1));
  int y = int(constrain(map(pscon.joyL.y, -threshold, threshold, 1, -1), -1, 1));
  int up = int(constrain(map(pscon.joyR.y, -threshold, threshold, 1, -1), -1, 1));
  int yaw = pscon.getLR2Val();
  //println("x:" + x);
  //println("y:" + y);
  //println("up:" + up);
  //println("yaw:" + yaw);
  if (isTakeoff) {
    tello.rcMove(x, y, up, yaw, speed);
  }
  fill(255);
  text("speed : "+str(speed), width/2-100, 100);
}
