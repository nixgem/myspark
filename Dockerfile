FROM apache/spark:3.4.4-scala

# sbtのリポジトリを追加してインストール
USER root
RUN apt-get update && apt-get install -y curl gnupg && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" > /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" >> /etc/apt/sources.list.d/sbt.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x99E82A75642AC823" | apt-key add - && \
    apt-get update && apt-get install -y sbt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/spark
RUN chown -R spark:spark /home/spark

USER spark
COPY . /opt/spark/work-dir