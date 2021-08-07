#!/bin/bash

pName=""
pDir=""
emptyDir=`pwd`
baseDir=`cd .. && pwd`

function getLoc() {
  echo "Creating new solidity project with truffle and ganache-cli"
  echo "Safe in the default location?"
  echo $baseDir
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) pDir="$baseDir" ; break;;
          No  ) getDirName exit;;
      esac
  done
}

getDirName() {
  
  echo "Where do you want to create the project?"
  read inDir
  if [ -z "$(ls -A $inDir)" ]; then
    echo "That dir doesn't exist!"
    exit -1
  else
    echo "Not Empty"
    pDir="$inDir"
  fi
}



getName() {

  echo "Saving to:"
  echo "$pDir"
  echo "What's the name of your project?"
  read name
  echo "So $pDir/$name is correct?"

  select yn in "yes" "no"; do
      case $yn in
          yes ) pName="$name" ; break;;
          no ) getName exit;;
      esac
  done
}


doIt() {
  echo "pDir: $pDir"
  echo "pName: $pName"
  echo "emptyDir: $emptyDir"
  cd "$pDir" && echo `pwd` &&
  [ -d "$pDir/$pName" ] || 
  cp -R "$emptyDir" "$pName" &&
  cd "$pDir/$pName" &&
  rm -rf .git &&
  rm createProject.sh && 
  git init &&
  git add . &&
  git commit -m "Initial Commit" &&
  echo "Successfully created Project!!"
}

args=4
parseArgs() {
  echo "$0 $1 $2 $3"
  if [ "$1" = "-d" ]; then
    pDir="$baseDir"
    if [ -z "$2" ]; then
      args=1
    else
      pName="$2"
      args=2
    fi
  else 
    args=0
  fi
  echo "$pDir/$pName"
}


# res=`parseArgs`
parseArgs $1 $2

case $args in
  0)
    getLoc
    getName
    doIt
    ;;
  1)
    getName
    doIt
    ;;
  2)
    doIt
    ;;
esac

