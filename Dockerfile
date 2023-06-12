# Стадия сборки
FROM gradle:7.0.2-jdk17 AS build

# Установка рабочего каталога в контейнере
WORKDIR /home/gradle/src

# Копирование gradle.properties и build.gradle
COPY gradle.properties .
COPY build.gradle .

# Копирование исходного кода
COPY src ./src

# Сборка приложения
RUN gradle clean build --no-daemon

# Стадия запуска
FROM openjdk:17-jdk

# Копирование исполняемого jar-файла в рабочую директорию "/app" контейнера
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
