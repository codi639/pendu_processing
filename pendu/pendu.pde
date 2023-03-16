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
int[] positionDrapeaux;
int indexPaysChoisi;
int indexPaysADeviner;

void setup(){
    size(1500, 600);
    background(0);
    fill(30);
    tableauPays = loadStrings("nom_pays_triee.txt");
    tableauDrapeaux = new PImage[tableauPays.length];
    tableauNombreAleatoire = new int[10];
    int[] positionDrapeaux = {120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200};
    for(int i = 0; i < tableauPays.length; i++){
        tableauDrapeaux[i] = loadImage("image_drapeau/w80/" + tableauPays[i] + ".png");
    }
    for (int i = 0; i < 6; i++) {
        tableauPendu[i] = loadImage("image_pendu/pendu" + (i + 1) + ".png"); // chargement des images du pendu
        tableauPendu[i].resize(170, 140);
    }
    
    // println(tableauPays.length, tableauDrapeaux.length);
    initialiserJeu();
}

void draw(){
    background(0);
}

void initialiserJeu(){
    for(int i = 0; i < tableauNombreAleatoire.length; i++){
        tableauNombreAleatoire[i] = int(random(49));
    }
    indexPaysADeviner = int(random(9));
    paysATrouver = tableauPays[indexPaysADeviner];
    println(paysATrouver);
}
