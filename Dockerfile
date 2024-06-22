# Usa la imagen base de OpenJDK
FROM openjdk:11

WORKDIR /app
# Copiar el archivo de java en el contenedor
COPY App.java .


RUN javac App.java

CMD ["java", "HelloWorld"]