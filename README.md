# Bataille_Navale_Ada
bataille navale avec placement de bateau aléatoire en langage ada.

pour les utilsateur de gnat sous linux executer le script compile.sh pour compiler et executer avec "./MainNavale"

pour les autre avec gcc cela doit ressembler a ça (toujours a partir de la ou ce trouve compile.sh)

gcc -c -I./source/ -I- ./source/bateau_pack.adb

gcc -c -I./source/ -I- ./source/terrain_pack.adb

gcc -c -I./source/ -I- ./source/MainNavale.adb
