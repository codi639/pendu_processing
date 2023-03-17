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
PImage[] tableauPendu = new PImage[6];
String paysATrouver;
int[] tableauNombreAleatoire;
int[] positionDrapeaux = {120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200};
int indexTampon;
int indexPaysATrouver;
int drapeauATrouver;

void setup(){
    size(1500, 600);
    background(200, 218, 170);
    //fill(30);
    fill(0);
    textSize(30);
    tableauPays = loadStrings("nom_pays_triee.txt");
    tableauDrapeaux = new PImage[tableauPays.length];
    tableauNombreAleatoire = new int[10];
    // int[] positionDrapeaux = {120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200};

    for(int i = 0; i < tableauPays.length; i++){
        tableauDrapeaux[i] = loadImage("image_drapeau/w80/" + tableauPays[i] + ".png");
    }
    for (int i = 0; i < 6; i++) {
        tableauPendu[i] = loadImage("image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
        tableauPendu[i].resize(170, 140);
    }
    
    // println(tableauPays.length, tableauDrapeaux.length);
    initialiserJeu();background(200, 218, 170);
}


void initialiserJeu(){
    for(int i = 0; i < tableauNombreAleatoire.length; i++){
        int aleaTampon = 0;
        int j = 0;
        tableauNombreAleatoire[i] = int(random(49));
        aleaTampon = int(random(49));
        for (j = 0; j < i; j++) {
            if (aleaTampon == tableauNombreAleatoire[j]) {
                aleaTampon = int(random(49));
                j = 0;
            }
        }
        tableauNombreAleatoire[i] = aleaTampon;
    }
    indexTampon = int(random(9));
    indexPaysATrouver = tableauNombreAleatoire[indexTampon];
    paysATrouver = tableauPays[indexPaysATrouver];
    
    println(paysATrouver);
}

void draw(){
    background(200, 218, 170);
    text("Jeu du Pendu", width/2 - 70, 50);
    image(tableauPendu[0], 100, 100);

    for (int i = 0; i < tableauNombreAleatoire.length; i++) {
        image(tableauDrapeaux[indexPaysATrouver], 1300, 100);
        image(tableauDrapeaux[tableauNombreAleatoire[i]], positionDrapeaux[i], 300);
    }
}