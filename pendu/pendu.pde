/**********************************************************************
 * Nom du fichier : pendu_processing.pde                              *
 * Auteur : Jean-Lou Gilbertas                                        *
 * Date de dernière modification : 21 mars 2023                       *
 * Référence de Processing : https://processing.org/reference.        *
 * Realisation d'une variante du jeux de Pendu en processing.         *
 **********************************************************************/


// Déclaration des variables globales
String[] tableauPays;
PImage[] tableauDrapeaux;
PImage[] tableauPendu = new PImage[7];
String paysATrouver;
String message;
int[] tableauNombreAleatoire;
int[] positionDrapeaux = {120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200};
int indexTampon;
int indexPaysATrouver;
int drapeauATrouver;
int positionXdrapeauATrouver;
int positionYDrapeauATrouver;
int rectX = 1300, rectY = 500;
int indexPendu;
boolean etatJeu = true;
boolean drapeauTrouve;
color couleurDeFond;
color couleurRejouer;
color couleurPerdu;
color couleurGagne;

void setup(){
    size(1500, 600);
    background(200, 218, 170);
    fill(0);
    textSize(30);

    // Initialisation du tableau des pays
    tableauPays = loadStrings("nom_pays_triee.txt");
    tableauDrapeaux = new PImage[tableauPays.length];
    tableauNombreAleatoire = new int[10];
    // Chargement des images des drapeaux
    for(int i = 0; i < tableauPays.length; i++){
        tableauDrapeaux[i] = loadImage("image_drapeau/w80/" + tableauPays[i] + ".png");
    }

    // Chargement des images du pendu
    for (int i = 0; i <= 6; i++) {
        tableauPendu[i] = loadImage("image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
        tableauPendu[i].resize(170, 140);
    }

    initialiserJeu();
}


void initialiserJeu(){
    // Réinitialisation des variables
    indexPendu = 0;
    drapeauTrouve = false;
    etatJeu = true;
    couleurDeFond = color(200, 218, 170);
    couleurRejouer = color(200, 218, 170);
    couleurPerdu = color(200, 218, 170);
    couleurGagne = color(200, 218, 170);

    // Initialisation du tableau de nombre aléatoire
    for(int i = 0; i < tableauNombreAleatoire.length; i++){
        int aleaTampon = 0;
        int indiceTampon = 0;
        tableauNombreAleatoire[i] = int(random(50));
        aleaTampon = int(random(50));
        for (indiceTampon = 0; indiceTampon < i; indiceTampon++) {
            if (aleaTampon == tableauNombreAleatoire[indiceTampon]) {
                aleaTampon = int(random(50));
                indiceTampon = 0;
            }
        }
        tableauNombreAleatoire[i] = aleaTampon;
    }

    // Sélection d'un drapeau aléatoire
    indexTampon = int(random(9));
    indexPaysATrouver = tableauNombreAleatoire[indexTampon];
    paysATrouver = tableauPays[indexPaysATrouver];
    positionXdrapeauATrouver = indexTampon * 120 + 120;
    positionYDrapeauATrouver = 400;
}

// Fonction qui permet de tester si le jouer a cliqué sur le bon drapeau ou non
void mouseClicked() {
    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        // Si le joueur clique sur un drapeau et non sur un drapeau qui a disparu
        if (mouseX > positionDrapeaux[i] - 10 && mouseX < positionDrapeaux[i] + 90 && mouseY > 390 && mouseY < 490 && tableauNombreAleatoire[i] != -1) {
            // Tant que le joueur n'a pas trouvé le bon drapeau et qu'il n'a pas utilisé tous ses essais
            if (indexPendu < 6 && !drapeauTrouve){
                // Si le joueur clique sur le bon drapeau
                if (mouseX > positionXdrapeauATrouver - 10 && mouseX < positionXdrapeauATrouver + 90 && mouseY > 400 - 10 && mouseY < 490) {
                    drapeauTrouve = true;
                    etatJeu = false;
                    couleurGagne = color(255, 0, 0);
                    partieTerminee();
                } 
                // Si le joueur clique sur un mauvais drapeau
                else {
                    indexPendu++;
                    // Si le joueur n'a pas utilisé tous ses essais
                    if (indexPendu < 6) {
                        tableauNombreAleatoire[i] = -1;
                    }
                    // Si le joueur a utilisé tous ses essais 
                    else {
                        etatJeu = false;
                        couleurPerdu = color(255, 0, 0);
                        partieTerminee();
                    }
                }
            }
        }
    }

    // Si le joueur clique sur le bouton rejouer
    if (mouseX > rectX && mouseX < rectX + 80 && mouseY > rectY && mouseY < rectY + 40 && (drapeauTrouve || !etatJeu)) {
        initialiserJeu();
    }
}

void draw(){
    background(200, 218, 170);
    
    // Affichage de la consigne du jeu
    fill(0);
    text("Jeu du Pendu", width/2 - 70, 50);
    text("Trouvez le drapeau du pays suivant :    " + paysATrouver, 100, 300);

    image(tableauPendu[indexPendu], 100, 100);
    // A décommenter si on veut afficher le drapeau à trouver
    image(tableauDrapeaux[indexPaysATrouver], 1300, 100);

    // Affichage du message de victoire
    if (drapeauTrouve) {
        fill(couleurGagne);
        text("Bravo, vous avez gagné !", 100, 550);
    } // Affichage du message de défaite 
    else {
        fill(couleurPerdu);
        text("Vous avez perdu !", 100, 550);
    }
    
    // Affichage des drapeaux
    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        fill(255, 255, 255, 128);
        rect(positionDrapeaux[i] - 10, 390, 100, 100);
        if (tableauNombreAleatoire[i] != -1) {
            
            image(tableauDrapeaux[tableauNombreAleatoire[i]], positionDrapeaux[i], 400);
        }
    }
    
    // Affichage du bouton rejouer
    stroke(couleurDeFond);
    fill(couleurDeFond);
    rect(rectX, rectY, 80, 40);
    fill(couleurRejouer);
    textSize(20);
    text("Rejouer", rectX + 10, rectY + 26);
}

void partieTerminee(){
    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        if (i != indexTampon) {
            tableauNombreAleatoire[i] = -1;
        }
    }

    // Initilisation des couleurs afin que le bouton rejouer soit visible
    couleurDeFond = color(150, 150, 150, 128);
    couleurRejouer = color(0, 0, 0);
}