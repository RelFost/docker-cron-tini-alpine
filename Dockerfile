FROM alpine:latest

# Устанавливаем curl, crond и tini
RUN apk add --no-cache curl tini busybox-suid

# Создаём рабочую директорию под лог и crontabs
RUN mkdir -p /var/log/cron && chmod 777 /var/log/cron

# Обеспечим права на crontab для пользователя root
RUN touch /etc/crontabs/root && chmod 600 /etc/crontabs/root

# tini как entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

# Команда запускает crond в foreground с логированием уровня 2
CMD ["crond", "-f", "-l", "2"]
