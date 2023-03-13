import java.io.file;

String folderPath = "../image_drapeau/w80";
String outputPath = "../image_drapeau_triee";

void trierFichiers(String folderPath, String outputPath) {
  File folder = new File(folderPath);
  if (folder.isDirectory()) {
    // Création du nouveau dossier
    String newFolderPath = outputPath + "/TrierParNom";
    newFolderPath.mkdir();

    // Récupération de la liste des fichiers du dossier
    String[] fileNames = folder.list();
    
    // Tri des noms de fichiers par ordre alphabétique
    for (int i = 0; i < fileNames.length - 1; i++) {
      for (int j = i + 1; j < fileNames.length; j++) {
        if (fileNames[i].compareTo(fileNames[j]) > 0) {
          String temp = fileNames[i];
          fileNames[i] = fileNames[j];
          fileNames[j] = temp;
        }
      }
    }
    
    // Copie des fichiers triés dans le nouveau dossier
    for (String fileName : fileNames) {
      File file = new File(folderPath + "/" + fileName);
      if (file.isFile()) {
        try {
          FileInputStream inputStream = new FileInputStream(file);
          FileOutputStream outputStream = new FileOutputStream(newFolderPath + "/" + fileName);
          byte[] buffer = new byte[1024];
          int length;
          while ((length = inputStream.read(buffer)) > 0) {
            outputStream.write(buffer, 0, length);
          }
          inputStream.close();
          outputStream.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
  } else {
    println("Le chemin spécifié n'est pas un dossier valide !");
  }
}
