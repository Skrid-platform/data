# Créer le dossier de sortie s'il n'existe pas
mkdir -p "./pdf"

# Boucle pour convertir chaque fichier SVG en PDF
for fichier in ./svg/*.svg; do
    # Extraire le nom du fichier sans le chemin et sans l'extension
    nom_fichier=$(basename "$fichier" .svg)

    # Construire le chemin de sortie correct
    fichier_pdf="./pdf/${nom_fichier}.pdf"

    # Afficher la commande avant exécution (debugging)
    echo "Conversion de: $fichier -> $fichier_pdf"

    # Exécuter la conversion
    rsvg-convert -f pdf -o "$fichier_pdf" "$fichier"
done

