# Базовый образ
FROM openjdk:17 as builder

# Перейти в рабочую директорию
WORKDIR /workspace/app

# Копирование gradlew
COPY gradlew .

# Изменение прав на исполнение для gradlew
RUN chmod +x ./gradlew

# Копирование директории gradle
COPY gradle gradle

# Копирование файла build.gradle
COPY build.gradle .

# Установка утилиты xargs
RUN apk add --no-cache findutils

# Загрузка зависимостей для повторного использования слоя Docker
RUN ./gradlew dependencies

# Копируем исходный код приложения
COPY src src

# Сборка приложения и удаление ненужных файлов
RUN ./gradlew build -x test
RUN mkdir -p build/dependency && (cd build/dependency; jar -xf ../libs/*.jar)

# Минимальный образ
FROM openjdk:17-jdk-alpine

ARG DEPENDENCY=/workspace/app/build/dependency

# Копируем зависимости
COPY --from=builder ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=builder ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=builder ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.demo.DemoApplication"]
