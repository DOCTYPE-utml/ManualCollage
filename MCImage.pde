class MCImage {
  PImage img;

  int tx=50, ty=50;
  int dx=0, dy=0;
  boolean grabbing=false;
  float magnification=1.0;

  MCImage(PImage _img) {
    img=_img;
  }

  PImage getImage() {
    if (img==null) {
      return null;
    }
    return resizedImage(img, (int)(img.width*magnification), (int)(img.height*magnification));
  }
}
