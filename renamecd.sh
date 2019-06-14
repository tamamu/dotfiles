if [ -n "$1" ]; then
  TMP=$(pwd)
  cd ..
  mv $TMP $1
  cd $1 && pwd
fi
