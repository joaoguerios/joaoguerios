#!/bin/bash
#script para Backup

principal() {
  clear

  echo "------------------------------------------"
  echo "  "
  echo "bem vindo ao menu do backup"
  echo "  "
  echo "voce gostaria de realizar um backup s/n"
  echo "  "
  echo "------------------------------------------"
  read Action1
  

  case $Action1 in
   s) Backup ;;
   n) echo ; exit  ;;
   *) echo "Opcao desconhecida." ; echo ; principal ;;
  esac
  }



Backup() {
  clear

  echo "------------------------------------------"
  echo "  "
  echo "bem vindo ao backup"
  echo "  "
  echo "Voce gostaria de realizar o backup somente dos documentos ou completo (/root)"
  echo "  "
  echo "c) para um backup completo "
  echo " "
  echo "e) para um backup de documentos especificos"
  echo "  "
  echo "------------------------------------------"
  read BackupType
  echo " "
  echo "qual o caminho até a pasta destino do backup?"
  read destino
  while [ ! -d "$destino" ]; do
        echo "Diretório de destino inválido."
        echo
        echo "qual o caminho até a pasta destino do backup?"
        read destino
   done

  case $BackupType in
  e) EspBackup  ;;
  c) FullBackup  ;;
  *) echo "Opcao desconhecida." ; echo ; principal ;;
  esac


}

EspBackup() {
   echo "Digite o caminho completo da pasta que deseja adicionar: " 
   read origem
   if [ -d "$origem" ]; then
      echo "Pasta adicionada com sucesso!"
      pastas+=("$origem")
   else
       echo "Pasta não encontrada."
   fi
   echo  
   echo "deseja continuar s/n? "
   read desejo
   until [ "$desejo" != "s" ]; do
    echo "Digite o caminho completo da pasta que deseja adicionar: " 
    read origem
    if [ -d "$origem" ]; then
       echo "Pasta adicionada com sucesso!"
       pastas+=("$origem")
    else
        echo "Pasta não encontrada."
    fi
    echo 
   done
   echo "Realizando backup..."
    for origem in "${pastas[@]}"; do
        rsync -auv --progress "$origem" "$destino"
    done
  echo "Backup concluído."
  echo
}

FullBackup() {
 echo "realizando backup"
 rsync -auv --progress /home "$destino"
 echo "backup feito"
}

clear

principal

