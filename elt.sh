!/bin/bash

#directorio en donde se almacena la informacion de las maquinas clientes

cd /home/elton


if [ -d "/home/elton/rest" ];
then 
rm -r /home/elton/rest
mkdir /home/elton/rest
else 
mkdir /home/elton/rest
fi



#conexion a la maquina cliente 1
ssh elton@192.168.1.1 'sleep 1 &'

#obtencion de  los estados de los componentes de la maquina
cat /proc/cpuinfo > estado_cpu1.txt
ps -aux > procesos1.txt
vmstat -s -S M > memoria1.txt
df -h > disco1.txt
networkctl > red1.txt

#envio de la informacion a la maquina servidor
scp estado_cpu1.txt procesos1.txt memoria1.txt disco1.txt red1.txt elton@192$

#borrado de los ficheros en la maquina clientes
rm estado_cpu1.txt procesos1.txt memoria1.txt disco1.txt red1.txt

#conexion a la maquina cliente 2
ssh elton@192.168.1.4 'sleep 1 &'

#obtencion de los estados de los componentes de la maquina
cat /proc/cpuinfo > estado_cpu2.txt
ps -aux > procesos2.txt
vmstat -s -S M > memoria2.txt
df -h > disco2.txt
networkctl > red2.txt

#envio de la informacion a la maquina servidor
scp estado_cpu2.txt procesos2.txt memoria2.txt disco2.txt red2.txt elton@192$

#borrado de los ficheros en la maquina cliente
rm estado_cpu2.txt procesos2.txt memoria2.txt disco2.txt red2.txt

#genera el fichero html en el caso de que este no exista.
if [ ! -f "/home/elton/pagina.html" ];
then
touch /home/elton/pagina.html
fi

#anexo de los datos al fichero html
echo " <!DOCTYPE html>" > pagina.html
echo "<html>" >> pagina.html
echo "<head>" >> pagina.html
echo "<meta charset: UTF8> <title> Monitoreo de estado </title>" >> pagina.h$
echo "</head>" >> pagina.html
echo "<body>" >> pagina.html
echo "<h1> Maquina 1 </h1>" >> pagina.html
echo  "<h2> Estado del cpu </h2>" >> pagina.html
echo "<p>" >> pagina.html
cat /home/elton/rest/estado_cpu1.txt >>pagina.html
echo "</p>" >> pagina.html
echo "<h2> Procesos en ejecucion </h2>" >>pagina.html
echo "<p>" >> pagina.html
cat /home/elton/rest/procesos1.txt >>pagina.html
echo "</p>" >> pagina.html
echo "<h2> Estado actual de la memoria </h2>" >>pagina.html
echo "<p>" >>pagina.html
cat /home/elton/rest/memoria1.txt >>pagina.html
echo "</p>" >>pagina.html
echo "<h2> Estado del disco </h2>" >>pagina.html
echo "<p>" >>pagina.html
cat /home/elton/rest/disco1.txt >>pagina.html
echo "</p>" >>pagina.html
echo "<h2> Estado de la Red </h2>" >>pagina.html
echo "<p>" >>pagina.html
cat /home/elton/rest/red1.txt >>pagina.html
echo "</p>" >>pagina.html
echo "<br/>" >>pagina.html
echo "<h1> Maquina 2 </h1>" >> pagina.html
echo  "<h2> Estado del cpu </h2>" >> pagina.html
echo "<p>" >> pagina.html
cat /home/elton/rest/estado_cpu2.txt >>pagina.html
echo "</p>" >> pagina.html
echo "<h2> Procesos en ejecucion </h2>" >>pagina.html
echo "<p>" >> pagina.html
cat /home/elton/rest/procesos2.txt >>pagina.html
echo "</p>" >> pagina.html
echo "<h2> Estado actual de la memoria </h2>" >>pagina.html
cho "<p>" >>pagina.html
cat /home/elton/rest/memoria2.txt >>pagina.html
echo "</p>" >>pagina.html
echo "<h2> Estado del disco </h2>" >>pagina.html
echo "<p>" >>pagina.html
cat /home/elton/rest/disco2.txt >>pagina.html
echo "</p>" >>pagina.html
echo "<h2> Estado de la Red </h2>" >>pagina.html
echo "<p>" >>pagina.html
cat /home/elton/rest/red2.txt >>pagina.html
echo "</p>" >>pagina.html
echo "</body>" >>pagina.html
echo  "</html>" >>pagina.html

echo "se concluyo con la estraccion de los ficheros probenientes del servidor"

