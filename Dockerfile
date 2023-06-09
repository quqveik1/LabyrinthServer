# Используем официальный образ OpenJDK 17 для сборки
FROM openjdk:17-jdk as builder

# Устанавливаем рабочую директорию в Docker
WORKDIR /workspace/app

# Копируем Gradle файлы в рабочую директорию
COPY gradlew .
COPY gradle gradle
COPY build.gradle .

# Загрузка зависимостей для повторного использования слоя Docker
RUN ./gradlew dependencies

# Копируем исходный код приложения
COPY src src

# Сборка приложения
RUN ./gradlew bootJar

# Следующая стадия в многостадийной сборке Docker
FROM openjdk:17-jre as production

ARG DEPENDENCY=/workspace/app/build/libs

# Копируем jar файл в контейнер
COPY --from=builder ${DEPENDENCY}/*.jar app.jar

# Запускаем приложение
ENTRYPOINT ["java","-jar","/app.jar"]
