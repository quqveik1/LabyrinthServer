# Выбираем базовый образ
FROM openjdk:11-jdk-slim

# Копируем .jar файл в контейнер
COPY out/artifacts/LabyrinthServer_jar/LabyrinthServer.jar app.jar

# Указываем команду для запуска приложения
ENTRYPOINT ["java","-jar","/app.jar"]
