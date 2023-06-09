# Используем базовый образ с Java
FROM openjdk:11-jdk-slim

# Добавляем в контейнер переменные окружения
ENV APP_HOME=/usr/app/

# Создаем директорию приложения внутри Docker образа
WORKDIR $APP_HOME

# Копируем файлы сборки в Docker образ
COPY build/libs/*.jar app.jar

# Команда для запуска нашего Spring Boot приложения внутри Docker контейнера
ENTRYPOINT ["java","-jar","app.jar"]
