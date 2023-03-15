/**********************************************************************
 * Nom du fichier : pendu_processing.pde                              *
 * Auteur : Jean-Lou Gilbertas                                        *
 * Date de dernière modification : 13 mars 2023                       *
 * Référence de Processing : https://processing.org/reference.        *
 * Realisation d'une variante du jeux de Pendu en processing.         *
 **********************************************************************/
/*
// Déclaration des variables globales
PImage[] tableauPendu = new PImage[7];
PImage[] tableauDrapeau = new PImage[50];
String[] tableauNomPays = new String[50];

PImage image1;
PImage image2;

void setup() {
  size(1135, 330);
  background(255);
  // Chargement des images des animaux et de l'image rouge
  image1 = loadImage("image_drapeau/w80/Tonga.png");
  for (int i = 0; i < 6; i++) {
    tableauPendu[i] = loadImage("image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
  }
  tableauNomPays = loadStrings("nom_pays_triee.txt"); // chargement du tableau des noms de pays
  for (int i = 0; i < tableauNomPays.length; i++) {
    tableauDrapeau[i] = loadImage("image_drapeau/w80/" + tableauNomPays[i] + ".png"); // chargement des images des drapeaux
  }
    image2 = loadImage("image_drapeau/w80/Allemagne.png");
  

  /* A décommenter pour afficher le contenu du tableau des noms de pays
  println("Nombre de lignes lues : " + tableauNomPays.length);
  for (int i = 0; i < tableauNomPays.length; i++) {
    println("Ligne " + i + " : " + tableauNomPays[i]);
  }

  //String[] filenames = loadStringsFromFile("nom_pays_triee.txt");
  // String [] filenames = tableauNomPays;
  /* A décommenter pour afficher le contenu du tableau des Drapeaux
  println("Nombre de fichiers lus : " + files.length);
  for (int i = 0; i < files.length; i++) {
    println("Fichier " + i + " : " + tableauNomPays[i] + " (" + files[i].length + " bytes)");
  }
  
  
}

void draw() {
  // Affichage des images
  image(image1, 0, 0);
  image(image2, 400, 0);
}*/



String[] nomPays; // tableau contenant la liste des noms de pays
PImage[] drapeauPays = new PImage[50]; // tableau contenant les images des drapeaux
PImage[] drapeauDeJeux; // tableau contenant les dix drapeaux choisis au hasard
int[] indexDrapeauChoisis; // tableau contenant les index des dix drapeaux choisis
int[] bouttonX; // tableau contenant les positions X des boutons pour sélectionner les pays
int[] bouttonY; // tableau contenant les positions Y des boutons pour sélectionner les pays
int buttonWidth = 100; // largeur des boutons pour sélectionner les pays
int buttonHeight = 60; // hauteur des boutons pour sélectionner les pays
int indexDuPaysADeviner; // index du pays dont le drapeau est affiché
int score = 0; // score du joueur
int round = 1; // numéro du tour en cours
int maxRounds = 10; // nombre de tours

void setup() {
  size(800, 600); // taille de la fenêtre de jeu
  background(255); // couleur de fond
  textSize(20); // taille de police pour le texte
  textAlign(CENTER, CENTER); // alignement du texte
  nomPays = loadStrings("nom_pays_triee.txt"); // chargement de la liste des pays depuis un fichier texte
  println("Nom du pays : " + nomPays[0]);
  int t = 0;
  PImage imageTampon = loadImage("image_drapeau/w80/" + nomPays[t] + ".png");

  // drapeauPays = loadFilesFromNames("image_drapeau/w80/"); // chargement des drapeaux depuis un dossier
  for (int i = 0; i < nomPays.length; i++) {
    drapeauPays[i] = loadImage("image_drapeau/w80/" + nomPays[i] + ".png");
    //drapeauPays[i] = loadImage("image_drapeau/w80/Portugal.png");
  }
  indexDrapeauChoisis = new int[10]; // initialisation du tableau des index des drapeaux choisis
  drapeauDeJeux = new PImage[10]; // initialisation du tableau des drapeaux choisis
  bouttonX = new int[5]; // initialisation du tableau des positions X des boutons
  bouttonY = new int[2]; // initialisation du tableau des positions Y des boutons
  // calcul des positions des boutons pour sélectionner les pays
  for (int i = 0; i < bouttonX.length; i++) {
    bouttonX[i] = (i+1) * (width/(bouttonX.length+1)) - buttonWidth/2;
  }
  for (int i = 0; i < bouttonY.length; i++) {
    bouttonY[i] = height/2 + (i-1) * buttonHeight;
  }
  newRound(); // initialisation d'un nouveau tour
}

void draw() {
  // affichage des drapeaux choisis
  for (int i = 0; i < drapeauDeJeux.length; i++) {
    image(drapeauDeJeux[i], bouttonX[i%5], bouttonY[i/5], buttonWidth, buttonHeight);
  }
  // affichage du texte
  fill(0);
  text("Round " + round + "/" + maxRounds + "\n\nQuel est le drapeau de ce pays ?", width/2, height/4);
  text("Score: " + score, width/2, height/8);
}

void newRound() {
  // Choix aléatoire des 10 drapeaux sans doublons
  int[] indexes = new int[nomPays.length];
  for (int i = 0; i < indexes.length; i++) {
    indexes[i] = i;
  }
  shuffle(indexes);
  int[] indexDrapeauChoisis = new int[10];
  for (int i = 0; i < 10; i++) {
    indexDrapeauChoisis[i] = indexes[i];
  }
  // Choix aléatoire du drapeau à deviner parmi les 10
  int indexDuPaysADeviner = indexDrapeauChoisis[floor(random(10))];
  drapeauDeJeux = new PImage[10];
  for (int i = 0; i < 10; i++) {
    drapeauDeJeux[i] = loadImage(drapeauPays[indexDrapeauChoisis[i]]);
  }
  // Stockage de l'index du drapeau à deviner
  indexDuPaysADevinerDansListe = indexDuPaysADeviner;
  // Recherche du nom du pays associé au drapeau à deviner
  paysADeviner = pays[indexDrapeauChoisis[indexDuPaysADeviner]];
}

void mousePressed() {
  // vérification si le clic est dans un des boutons
  for (int i = 0; i < drapeauDeJeux.length; i++) {
    if (mouseX > bouttonX[i%5] && mouseX < bouttonX[i%5] + buttonWidth && mouseY > bouttonY[i/5] && mouseY < bouttonY[i/5] + buttonHeight) {
      // vérification si la réponse est correcte
      if (indexDrapeauChoisis[i] == indexDuPaysADeviner) {
        score++;
        println("Correct!");
      } else {
        println("Wrong!");
      }
      round++;
      if (round > maxRounds) {
        println("Game Over! Final score: " + score);
        noLoop();
      } else {
        newRound();
      }
      break;
    }
  }
}

/*PImage[] loadFilesFromNames(String folderPath) {
  // chargement des noms de fichiers depuis le dossier
  File folder = new File(folderPath);
  File[] files = folder.listFiles();
  String[] fileNames = new String[files.length];
  for (int i = 0; i < files.length; i++) {
    if (files[i].isFile()) {
      String fileName = files[i].getName();
      fileNames[i] = fileName.substring(0, fileName.lastIndexOf('.'));
    }
  }
  
  // chargement des images depuis les fichiers correspondant aux noms de pays
  PImage[] images = new PImage[fileNames.length];
  for (int i = 0; i < fileNames.length; i++) {
    String fileName = fileNames[i];
    images[i] = loadImage(folderPath + fileName + ".png");
  }
  return images;
}*/