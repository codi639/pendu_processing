PImage[] tableauPendu = new PImage[7];

PImage image1;
PImage image2;

void setup() {
  size(1135, 330);
  background(255, 10, 0);
  // Chargement des images des animaux et de l'image rouge
  image1 = loadImage("../image_drapeau/w80/ad.png");
  for (int i = 0; i < 6; i++) {
    tableauPendu[i] = loadImage("../image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
  }
    image2 = loadImage("../image_drapeau/w80/ae.png");

}

void draw() {
  // Affichage des images
  image(image1, 0, 0);
  image(image2, 400, 0);
}