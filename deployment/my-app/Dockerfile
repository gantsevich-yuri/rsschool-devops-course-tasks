From bitnami/python:3.13.5

WORKDIR /app
COPY . .
RUN pip install --upgrade pip setuptools && pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8080

CMD ["python", "main.py"]
#CMD ["flask", "run"]