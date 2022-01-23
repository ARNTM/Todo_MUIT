% Cerrar todos los puertos serie abiertos que pudiera tener Matlab
delete(instrfindall)
% Crear un objeto para usar el puerto serie al que está conectado el Arduino
arduino = serial( 'COM11' );
% Configurar el puerto serie
set(arduino,'DataBits',8);
set(arduino,'StopBits',1);
set(arduino,'BaudRate',9600);
% Abrir el puerto serie con el que se comunica el Arduino
pause(18);
fopen(arduino);

while(1)
% Esperar un dato del arduino
while(arduino.BytesAvailable==0)
end
pause(1);
B=fscanf(arduino,'%f')

% Escribir valor en el canal de ThingSpeak
thingSpeakWrite(1637342,B,'WriteKey','DUCV7CSZ4LZAJWGK');

end
% Cerrar el puerto serie con el que se comunica el Arduino
fclose(arduino);