#!/bin/bash

function compile() {
  echo "----- Compiling..."
  unset toCompile

  cd $1

  if [ $# -lt 2 ]
  then
    for file in *
    do
      if testFilePath $file
      then
        if [ ".${file##*.}" == ".cpp" ]
        then
          toCompile+=($file)
        fi
      fi
    done
  else
    unset toIgnore

    for arg in $( eval echo {2..$#} )
    do
      toIgnore+=(${!arg})
    done

    for file in *
    do
      if testFilePath $file
      then
        if [ ".${file##*.}" == ".cpp" ]
        then
          if echo ${toIgnore[@]} | grep -q -w $file
          then
              echo "$file ignored."
          else
              toCompile+=($file)
          fi
        fi
      fi
    done
  fi

  echo "Compiling of ${toCompile[*]} into mainTqt."
  g++ ${toCompile[*]} -o mainTqt -std=c++20
  echo "----- Compiling complete.\n"
}

function run() {
  cd $1
  if testFilePath $1/mainTqt
  then
    echo "----- Launching mainTqt."
    $1/mainTqt
  else
    echo "$1/mainTqt does not exist."
    while true
    do
      read -p "Do you want to compile and run ? (y/n) : " -n 1
      echo
      [[ "$REPLY" != "y" && "$REPLY" != "n" ]] || break
    done

    if [ $REPLY == "y" ]
    then
      while true
      do
        read -p "Do you not want to compile certain files ? (y/n) : " -n 1
        echo
        REPLY2=$REPLY
        [[ "$REPLY2" != "y" && "$REPLY2" != "n" ]] || break
      done

      if [ $REPLY2 == "y" ]
      then
        while true
        do
          read -p "Name(s) of the file(s) that you want to ignore : "
          echo
          REPLY3=$REPLY

          unset existingFiles
          unset unexistingFiles

          for file in $REPLY3
          do
            if testFilePath $file
            then
              existingFiles+=($file)
            else
              unexistingFiles+=($file)
            fi
          done

          if [ ${#unexistingFiles[@]} == 0 ]
          then
            compile $1 ${existingFiles[*]}
            break
          else
            echo "-- error: file(s):"
            echo "${unexistingFiles[*]}"
            echo  "-- not existing"
          fi
        done
      else
        compile $1
      fi
    fi
  fi
}

function testFilePath() {
  [ -f $1 ]
}

function testFolderPath() {
  [ -d $1 ]
}


if [ $# -lt 1 ]
then
  echo "Not enough arguments."
else
  if [ $# == 2 ]
  then
    if testFolderPath $2
    then
      compile $2
      run $2
    fi
  fi
  case $2 in
    "-c")
      compile $@
      ;;
    "-r")
      run $1
      ;;
      *)
      compile $@
      run $1
      ;;
  esac
fi
