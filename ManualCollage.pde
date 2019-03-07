import processing.awt.*;
import java.awt.*;
import javax.swing.*;

JPanel panel;
List<MCImage> plant=new ArrayList();
boolean support=false;
int tx=width, ty=height, bx=0, by=0;

void setup() {
  size(800, 800);

  panel=new JPanel();
  panel.setBounds(0, 0, width, height);
  panel.setTransferHandler(new DropFileMCImager(plant));

  Canvas canvas =(Canvas)surface.getNative();
  Container pane =(Container)canvas.getParent();
  pane.add(panel);
}

void draw() {
  background(-1);

  for (int i=0; i<plant.size(); i++) {
    MCImage mcimg=plant.get(i);
    if (mcimg.grabbing) {
      mcimg.tx=mouseX-mcimg.dx;
      mcimg.ty=mouseY-mcimg.dy;
    }
    image(mcimg.getImage(), mcimg.tx, mcimg.ty);
    if (support) {
      stroke(255, 0, 0);
      strokeWeight(2);
      noFill();
      rect(mcimg.tx, mcimg.ty, mcimg.getImage().width, mcimg.getImage().height);
    }
  }

  if (plant.size()>0) {
    if (frameCount%5==0) {
      tx=width;
      ty=height;
      bx=0;
      by=0;
      for (int i=0; i<plant.size(); i++) {
        MCImage mcimg=plant.get(i);
        if (tx>mcimg.tx) {
          tx=mcimg.tx;
        }
        if (ty>mcimg.ty) {
          ty=mcimg.ty;
        }
        if (bx<mcimg.tx+mcimg.getImage().width) {
          bx=mcimg.tx+mcimg.getImage().width;
        }
        if (by<mcimg.ty+mcimg.getImage().height) {
          by=mcimg.ty+mcimg.getImage().height;
        }
      }
    }
    if (support) {
      stroke(0, 0, 255);
      strokeWeight(2);
      noFill();
      rect(tx, ty, bx-tx, by-ty);
    }
  }
}

void mousePressed() {
  boolean oneGrabbed=false;
  for (int i=plant.size()-1; i>=0; i--) {
    MCImage mcimg=plant.get(i);
    if (!oneGrabbed && (mouseX>=mcimg.tx && mouseX<=mcimg.tx+mcimg.getImage().width && mouseY>=mcimg.ty && mouseY<=mcimg.ty+mcimg.getImage().height)) {
      oneGrabbed=true;
      mcimg.grabbing=true;
      mcimg.dx=mouseX-mcimg.tx;
      mcimg.dy=mouseY-mcimg.ty;
    }
  }
}

void mouseReleased() {
  for (int i=0; i<plant.size(); i++) {
    MCImage mcimg=plant.get(i);
    mcimg.grabbing=false;
  }
}

void keyPressed() {
  switch(key) {
  case 's':
    support=!support;
    break;
  case ENTER:
    if (plant.size()>0) {
      PImage saveImg=get(tx, ty, bx-tx, by-ty);
      saveImg.save("./data/output"+day()+hour()+minute()+second()+".png");
      //save("./data/output"+day()+hour()+minute()+second()+".png");
    }
    break;
  }
}

void mouseWheel(MouseEvent event) {
  for (int i=0; i<plant.size(); i++) {
    MCImage mcimg=plant.get(i);
    if (mcimg.grabbing) {
      if (event.getAmount()==-1 && mcimg.magnification<2.9) {
        mcimg.magnification+=0.1;
      } else if (mcimg.magnification>0.1) {
        mcimg.magnification-=0.1;
      }
    }
  }
}
