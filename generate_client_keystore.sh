rm -f conf/simulador-key-client.jks
rm -f ../simulador-api/conf/simulador-key-client.jks
rm -f ../simulador-web/conf/simulador-key-client.jks

keytool -genkeypair \
        -storepass simulador-key-client \
        -storetype PKCS12 \
        -keyalg RSA \
        -keysize 2048 \
        -dname "CN=client" \
        -alias simulador.key \
        -ext "SAN:c=DNS:localhost,IP:127.0.0.1" \
        -keystore conf/simulador-key-client.jks

cp conf/simulador-key-client.jks ../simulador-api/conf/simulador-key-client.jks
cp conf/simulador-key-client.jks ../simulador-web/conf/simulador-key-client.jks
