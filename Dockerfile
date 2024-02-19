FROM python:3.12.1-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev

COPY pyproject.toml poetry.lock /app/
RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-root --no-interaction --no-ansi

COPY . /app/

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
