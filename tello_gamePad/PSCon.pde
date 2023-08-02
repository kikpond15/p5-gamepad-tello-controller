class PSCon {
  PVector joyR = new PVector(0, 0); //Right joystick
  PVector joyL = new PVector(0, 0); //Left joystick
  float rjB[], ljB[]; //Push joystick
  float upB[], downB[], rB[], lB[]; //Right side 4 button
  float r1B, l1B, r2B, l2B; //R1 R2 L1 L2 button (R2 and L2 is analog slider)
  float cmB[], rmB[], lmB[]; // Menu button (Right, Center, Left)

  PSCon() {
    rjB = new float[2];
    ljB = new float[2];
    upB = new float[2];
    downB = new float[2];
    rB = new float[2];
    lB = new float[2];
    cmB = new float[2];
    rmB = new float[2];
    lmB = new float[2]; 
  }

  void updateButtons() {
    //for (int i = 0; i < device.getNumberOfButtons(); i++) {
    //  ControlButton button = device.getButton(i);
    //  if (button.pressed())println(i);//押したボタンの数字を表示
    //}
    upB[1] = upB[0];
    downB[1] = downB[0];
    rB[1] = rB[0];
    lB[1] = lB[0];
    cmB[1] = cmB[0];
    rmB[1] = rmB[0];
    lmB[1] = lmB[0];
    rjB[1] = rjB[0];
    ljB[1] = ljB[0];

    upB[0] = device.getButton(3).getValue();
    downB[0] = device.getButton(1).getValue();
    rB[0] = device.getButton(0).getValue();
    lB[0] = device.getButton(2).getValue();
    r1B = device.getButton(4).getValue();
    l1B = device.getButton(5).getValue();
    cmB[0] = device.getButton(13).getValue();
    rmB[0] = device.getButton(9).getValue();
    lmB[0] = device.getButton(8).getValue();
    rjB[0] = device.getButton(11).getValue();
    ljB[0] = device.getButton(10).getValue();
  }

  void updateSliders() {
    //for (int i = 0; i < device.getNumberOfSliders(); i++) {
    //  ControlSlider slider = device.getSlider(i);
    //println(i + ": " + slider.getValue());//-1.0 to 1.0
    //0:RY, 1:RX, 2:LY, 3:LX, 4:R2, 5:L2
    //}
    joyL.x = device.getSlider(0).getValue();
    joyL.y = device.getSlider(1).getValue();
    joyR.x = device.getSlider(2).getValue();
    joyR.y = device.getSlider(3).getValue();
    l2B = device.getSlider(4).getValue();
    r2B = device.getSlider(5).getValue();
  }
  
  boolean isPressedButton(float[] b){
    if(b[1] > b[0]) return true;
    else return false;
  }

  int getLR2Val() {
    int val = 0;
    if (l2B == -1.0 && r2B == -1.0) val = 0;
    else if (l2B > 0 && r2B > 0) val = 0;
    else if (l2B == -1.0 && r2B > 0) val = 1;
    else if (l2B > 0 && r2B == -1.0) val = -1;
    return val;
  }

  void drawController() {
    stroke(255);
    //menu button
    fill(255*lmB[0]);
    ellipse(width/2-75, height-200, 25, 25);
    fill(255*rmB[0]);
    ellipse(width/2+75, height-200, 25, 25);
    fill(255*cmB[0]);
    rect(width/2 - 50, height/2 + 50, 100, 50);

    //right 4 button
    fill(255*rB[0]);
    rect(width/2+100, height/2-50, 25, 25);
    fill(255*downB[0]);
    rect(width/2+125, height/2-25, 25, 25);
    fill(255*lB[0]);
    rect(width/2+150, height/2-50, 25, 25);
    fill(255*upB[0]);
    rect(width/2+125, height/2-75, 25, 25);

    //joyStick
    fill(255*rjB[0]);
    ellipse((width/2+200)+joyR.x*50, (height/2+100)+joyR.y*50, 50, 50);
    fill(255*ljB[0]);
    ellipse((width/2-200)+joyL.x*50, (height/2+100)+joyL.y*50, 50, 50);

    //L1,2 R1,2
    fill(255*r1B);
    rect(50, (height/2-150)+l2B*50, 50, 50);
    fill(255*l1B);
    rect(width-100, (height/2-150)+r2B*50, 50, 50);
  }
}
