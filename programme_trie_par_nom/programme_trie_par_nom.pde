void setup()
{
  String fichierNonTrie = "Z:/Jean-Lou_Gilbertas/PII/Processing/TP1/nom_pays.txt";
  String fichierTrie = "Z:/Jean-Lou_Gilbertas/PII/Processing/TP1/fichier_pays_triee.txt";

  String[] chaines = loadStrings(fichierNonTrie);

    /*Arrays.sort(chaines);
    Collections.reverse(Arrays.asList(chaines));*/
    trierDecroissant(chaines);

    saveStrings(fichierTrie, chaines);

    for (String chaine : chaines)
    {
      println(chaine);
    }

}

void trierDecroissant(String[] tableau){
    for (int i = 0; i < tableau.length - 1; i++) {
        for (int j = i + 1; j < tableau.length; j++) {
        if (tableau[j].compareTo(tableau[i]) < 0) {
            String temp = tableau[i];
            tableau[i] = tableau[j];
            tableau[j] = temp;
        }
        }
    }
}
