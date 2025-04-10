FROM python:3.12

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app
WORKDIR /app

EXPOSE 8082

CMD ["gunicorn","--config", "gunicorn_config.py", "app:app"]
