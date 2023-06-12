# Стадия сборки
FROM gradle:6.9.1-jdk17 AS build

# Установка рабочего каталога в контейнере
WORKDIR /home/gradle/src

# Копирование gradle.properties и build.gradle
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
COPY gradlew.bat .

# Копирование исходного кода
COPY src ./src

# Сборка приложения
RUN gradle clean build

# Стадия запуска
FROM openjdk:17-jdk-oracle

# Копирование исполняемого jar-файла в рабочую директорию "/app" контейнера
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "/app/app.jar"]