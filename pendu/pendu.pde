/**********************************************************************
 * Nom du fichier : pendu_processing.pde                              *
 * Auteur : Jean-Lou Gilbertas                                        *
 * Date de dernière modification : 21 mars 2023                       *
 * Référence de Processing : https://processing.org/reference.        *
 * Realisation d'une variante du jeux de Pendu en processing.         *
 **********************************************************************/


/* Déclaration des variables globales */
// Tableaux des pays, drapeaux et images du pendu
String[] tableauPays;
PImage[] tableauDrapeaux;
PImage[] tableauPendu = new PImage[7];
// Variable pour le pays à trouver 
String paysATrouver;
// Tableau de nombre aléatoire et de position des drapeaux
int[] tableauNombreAleatoire;
int[] positionDrapeaux = {120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200};
// Variables pour les indices et index nécessaire au jeu
int indexTampon;
int indexPaysATrouver;
int drapeauATrouver;
int indexPendu;
// Variables pour la position du drapeau à trouver
int positionXdrapeauATrouver;
int positionYDrapeauATrouver;
// Variables pour la position du rectangle de rejouer
int rectX = 1300, rectY = 500;
// Variable pour l'état du jeu et pour savoir si le joueur a trouvé le bon drapeau ou s'il a perdu la partie
boolean etatJeu = true;
boolean drapeauTrouve;
// Variable pour les couleurs du jeu
color couleurDeFond;
color couleurRejouer;
color couleurPerdu;
color couleurGagne;

void setup(){
    // Initialisation de la fenêtre
    size(1500, 600);
    background(200, 218, 170);
    fill(0);
    textSize(30);

    // Initialisation du tableau des pays
    tableauPays = loadStrings("nom_pays_triee.txt");
    // Initialisation du tableau des drapeaux
    tableauDrapeaux = new PImage[tableauPays.length];
    // Initialisation du tableau de nombre aléatoire
    tableauNombreAleatoire = new int[10];

    // Chargement des images des drapeaux
    for(int indiceDrapeau = 0; indiceDrapeau < tableauPays.length; indiceDrapeau++){
        tableauDrapeaux[indiceDrapeau] = loadImage("image_drapeau/w80/" + tableauPays[indiceDrapeau] + ".png");
    }

    // Chargement des images du pendu
    for (int indicePendu = 0; indicePendu <= 6; indicePendu++) {
        tableauPendu[indicePendu] = loadImage("image_pendu/pendu" + (indicePendu + 1) + ".png"); // chargement des images du pendu
        tableauPendu[indicePendu].resize(300, 240);
    }

    initialiserJeu();
}


void initialiserJeu(){
    /* Réinitialisation des variables */
    // Index pour l'état du pendu
    indexPendu = 0;
    // Le joueur n'a pas trouvé le drapeau (pas encore...)
    drapeauTrouve = false;
    // Le jeu est en cours
    etatJeu = true;
    // Couleur de fond
    couleurDeFond = color(200, 218, 170);
    couleurRejouer = color(200, 218, 170);
    couleurPerdu = color(200, 218, 170);
    couleurGagne = color(200, 218, 170);

    // Initialisation du tableau de nombre aléatoire
    for(int indiceNombreAlea = 0; indiceNombreAlea < tableauNombreAleatoire.length; indiceNombreAlea++){
        int aleaTampon = 0;
        int indiceTampon = 0;
        // Remplissage du tableau de nombre aléatoire
        tableauNombreAleatoire[indiceNombreAlea] = int(random(50));
        aleaTampon = int(random(50));
        // Vérification que le nombre aléatoire n'est pas déjà dans le tableau
        for (indiceTampon = 0; indiceTampon < indiceNombreAlea; indiceTampon++) {
            // Si le nombre aléatoire est déjà dans le tableau, on en génère un nouveau
            if (aleaTampon == tableauNombreAleatoire[indiceTampon]) {
                aleaTampon = int(random(50));
                indiceTampon = 0;
            }
        }
        tableauNombreAleatoire[indiceNombreAlea] = aleaTampon;
    }

    // Sélection d'un drapeau aléatoire
    indexTampon = int(random(9));
    indexPaysATrouver = tableauNombreAleatoire[indexTampon];
    paysATrouver = tableauPays[indexPaysATrouver];

    // Détermination de la position du drapeau à trouver
    positionXdrapeauATrouver = indexTampon * 120 + 120;
    positionYDrapeauATrouver = 400;
}

// Fonction qui permet de tester si le jouer a cliqué sur le bon drapeau ou non
void mouseClicked() {
    for (int compteur = 0; compteur < tableauNombreAleatoire.length; compteur++) {
        // Si le joueur clique sur un drapeau et non sur un drapeau qui a disparu
        if (mouseX > positionDrapeaux[compteur] - 10 && mouseX < positionDrapeaux[compteur] + 90 && mouseY > 390 && mouseY < 490 && tableauNombreAleatoire[compteur] != -1) {
            // Tant que le joueur n'a pas trouvé le bon drapeau et qu'il n'a pas utilisé tous ses essais
            if (indexPendu < 6 && !drapeauTrouve){
                // Si le joueur clique sur le bon drapeau
                if (mouseX > positionXdrapeauATrouver - 10 && mouseX < positionXdrapeauATrouver + 90 && mouseY > 400 - 10 && mouseY < 490) {
                    // Le drapeau est trouvé
                    drapeauTrouve = true;
                    // Le jeu est fini
                    etatJeu = false;
                    // On affiche le message de victoire
                    couleurGagne = color(255, 0, 0);
                    partieTerminee();
                } 
                // Si le joueur clique sur un mauvais drapeau
                else {
                    indexPendu++;
                    // Si le joueur n'a pas utilisé tous ses essais
                    if (indexPendu < 6) {
                        tableauNombreAleatoire[compteur] = -1;
                    }
                    // Si le joueur a utilisé tous ses essais 
                    else {
                        // Le jeu est fini
                        etatJeu = false;
                        // On affiche le message de défaite
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

    image(tableauPendu[indexPendu], 100, 30);
    // A décommenter si on veut afficher le drapeau à trouver
    // image(tableauDrapeaux[indexPaysATrouver], 1300, 100);

    // Affichage du message de victoire
    if (drapeauTrouve) {
        fill(couleurGagne);
        text("Bravo, vous avez gagné !", 100, 550);
    } 
    // Affichage du message de défaite 
    else {
        fill(couleurPerdu);
        text("Vous avez perdu !", 100, 550);
    }
    
    // Affichage des drapeaux
    for (int indexClique = 0; indexClique < tableauNombreAleatoire.length; indexClique++) {
        fill(255, 255, 255, 128);
        rect(positionDrapeaux[indexClique] - 10, 390, 100, 100);
        // Vérification de n'afficher que les drapeaux qui n'ont pas été cliqués
        if (tableauNombreAleatoire[indexClique] != -1) {
            image(tableauDrapeaux[tableauNombreAleatoire[indexClique]], positionDrapeaux[indexClique], 400);
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
    for (int indexClique = 0; indexClique < tableauNombreAleatoire.length; indexClique++) {
        if (indexClique != indexTampon) {
            tableauNombreAleatoire[indexClique] = -1;
        }
    }

    // Initilisation des couleurs afin que le bouton rejouer soit visible
    couleurDeFond = color(150, 150, 150, 128);
    couleurRejouer = color(0, 0, 0);
}