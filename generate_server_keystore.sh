rm -f conf/simulador-key-server.jks
rm -f ../simulador-api/conf/simulador-key-server.jks
rm -f ../simulador-web/conf/simulador-key-server.jks

keytool -genkeypair \
        -storepass simulador-key-server \
        -storetype PKCS12 \
        -keyalg RSA \
        -keysize 2048 \
        -dname "CN=server" \
        -alias simulador.key \
        -ext "SAN:c=DNS:localhost,IP:127.0.0.1,DNS:simulador-key-service,DNS:key.tlaco.tec" \
        -keystore conf/simulador-key-server.jks

cp conf/simulador-key-server.jks ../simulador-api/conf/simulador-key-server.jks
cp conf/simulador-key-server.jks ../simulador-web/conf/simulador-key-server.jks
