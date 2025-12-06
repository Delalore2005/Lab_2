FROM jupyter/pyspark-notebook:spark-3.3.0

WORKDIR /home/470177/work

COPY . /home/470177/work

RUN pip install --no-cache-dir -r requirements.txt

RUN wget https://jdbc.postgresql.org/download/postgresql-42.6.0.jar -O /home/470177/postgresql-jdbc.jar
