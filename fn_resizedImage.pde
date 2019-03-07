PImage resizedImage(PImage img, int w, int h) {
  PGraphics g;
  g=createGraphics(w, h, JAVA2D);
  g.beginDraw();
  g.image(img, 0, 0, w, h);
  g.endDraw();
  return g;
}
