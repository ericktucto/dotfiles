#!/bin/bash

while true; do
  clear
  echo "---------------" >> logger.log
  date >> logger.log
  echo "---------------" >> logger.log

  echo "---------------" >> logger.log
  echo "MEM" >> logger.log
  echo "---------------" >> logger.log

  # ps aux --sort=-%mem | head -n 4 >> logger.log
  ps aux --sort -rss | head -n 4 | awk '{print $2, $6/1024 "MB", $11}' >> logger.log

  echo "---------------" >> logger.log
  echo "CPU" >> logger.log
  echo "---------------" >> logger.log

  ps aux --sort=-%cpu | head -n 4 | awk '{print $2, $3, $6/1024 "MB", $11}' >> logger.log
  tail -n 17 logger.log
  sleep 2
  # sleep 120  # Espera 2 minutos (120 segundos) antes de ejecutar el comando nuevamente
done

