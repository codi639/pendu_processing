/**********************************************************************
 * Nom du fichier : pendu_processing.pde                              *
 * Auteur : Jean-Lou Gilbertas                                        *
 * Date de dernière modification : 15 mars 2023                       *
 * Référence de Processing : https://processing.org/reference.        *
 * Realisation d'une variante du jeux de Pendu en processing.         *
 **********************************************************************/

import java.util.*;

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
int rectX = 1000, rectY = 600;
int indexPendu;
color couleurBoutonRejouer;
boolean etatJeu = true;
boolean drapeauTrouve;
color couleurDeFond = color(200, 218, 170);
color couleurRejouer = color(200, 218, 170);
color couleurPerdu = color(200, 218, 170);
color couleurGagne = color(200, 218, 170);

void setup(){
    size(1500, 600);
    background(200, 218, 170);
    //fill(30);
    fill(0);
    textSize(30);
    tableauPays = loadStrings("nom_pays_triee.txt");
    tableauDrapeaux = new PImage[tableauPays.length];
    tableauNombreAleatoire = new int[10];

    for(int i = 0; i < tableauPays.length; i++){
        tableauDrapeaux[i] = loadImage("image_drapeau/w80/" + tableauPays[i] + ".png");
    }
    for (int i = 0; i <= 6; i++) {
        tableauPendu[i] = loadImage("image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
        tableauPendu[i].resize(170, 140);
    }
    fill(couleurDeFond);
    rect(rectX, rectY, 80, 40);
    text("Rejouer", rectX + 10, rectY + 30);
    
    // println(tableauPays.length, tableauDrapeaux.length);
    initialiserJeu();
    background(200, 218, 170);
}


void initialiserJeu(){
    indexPendu = 0;
    couleurDeFond = color(200, 218, 170);
    couleurRejouer = color(200, 218, 170);
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
    indexTampon = int(random(9));
    indexPaysATrouver = tableauNombreAleatoire[indexTampon];
    paysATrouver = tableauPays[indexPaysATrouver];
    positionXdrapeauATrouver = indexTampon * 120 + 120;
    positionYDrapeauATrouver = 400;


    message = "";
    couleurBoutonRejouer = color(200, 218, 170);
    
    println(paysATrouver);
}

void mouseClicked() {
    /*
    Boucle while tant que etaJeu est vrai tester la position de la souris si drapeau trouvé etatJeu = false si trop d'essai etatJeu = false si mauvais tableau metre image verte par dessus
    */
 
    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        if (mouseX > positionDrapeaux[i] - 10 && mouseX < positionDrapeaux[i] + 90 && mouseY > 390 && mouseY < 490) {
            if (indexPendu < 6 && !drapeauTrouve){
                if (mouseX > positionXdrapeauATrouver - 10 && mouseX < positionXdrapeauATrouver + 90 && mouseY > 400 - 10 && mouseY < 490) {
                    drapeauTrouve = true;
                    etatJeu = false;
                    println("Bravo");
                    partieTerminee();
                } else {
                    indexPendu++;
                    println("Mauvais");
                    if (indexPendu < 6) {
                        tableauNombreAleatoire[i] = -1;
                    } else {
                        etatJeu = false;
                        partieTerminee();
                    }
                }
            }
        }
    }
    if (mouseX > rectX && mouseX < rectX + 80 && mouseY > rectY && mouseY < rectY + 40 && (drapeauTrouve || etatJeu == false)) {
        couleurPerdu = color(200, 218, 170);
        couleurGagne = color(200, 218, 170);
        initialiserJeu();
    }
}

void draw(){
    background(200, 218, 170);
    
    fill(0);
    text("Jeu du Pendu", width/2 - 70, 50);
    text("Trouvez le drapeau du pays suivant : " + paysATrouver, 100, 300);

    image(tableauPendu[6], 100, 100);
    image(tableauPendu[indexPendu], 100, 100);
    image(tableauDrapeaux[indexPaysATrouver], 1300, 100);

    fill(couleurGagne);
    text("Gagné", 100, 530);

    fill(couleurPerdu);
    text("Perdu", 100, 550);

    fill(couleurDeFond);
    rect(rectX, rectY, 80, 40);
    text("Rejouer", rectX + 10, rectY + 30);

    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        fill(255, 255, 255, 128);
        rect(positionDrapeaux[i] - 10, 390, 100, 100);
        if (tableauNombreAleatoire[i] != -1) {
            
            image(tableauDrapeaux[tableauNombreAleatoire[i]], positionDrapeaux[i], 400);
        }
    }

}

void partieTerminee(){
    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        if (i != indexTampon) {
            tableauNombreAleatoire[i] = -1;
        }
    }
    couleurDeFond = color(255, 0, 0);
}