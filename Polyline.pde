
class SortByX implements Comparator<PVector>
{
  int compare(PVector v1, PVector v2)
  {
    return ((Float)v1.x).compareTo(v2.x);
  }
}


class Polyline {

  ArrayList<PVector> pts = new ArrayList<PVector>();
  SortByX sorter = new SortByX();

  void add(float x, float y) {
    pts.add(new PVector(x, y));
    Collections.sort(pts, sorter);
  }

  void printPts() {
    for (int i=0; i<pts.size(); i++) {
      println(i, " ", pts.get(i).toString());
    }
  }

  float getValueAt(float xpos) {
    int n = 0;
    while (pts.get(n+1).x < xpos && n < pts.size()-2) n++;
    PVector p1 = pts.get(n);
    PVector p2 = pts.get(n+1);
    PVector diff = PVector.sub(p2, p1);
    float pct = abs((p1.x - xpos) / diff.x);
    return p1.y + (diff.y * pct);
  }

  void draw(float y_scale) {
    beginShape(LINES);
    for (int i=0; i<pts.size()-1; i++) {
      vertex(pts.get(i).x * width, height - (pts.get(i).y * y_scale));
      vertex(pts.get(i+1).x * width, height - (pts.get(i+1).y * y_scale));
    }
    endShape();
  }
}
