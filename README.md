# Dota Heroes

## Opis projektu

Dota Heroes Explorer to aplikacja mobilna stworzona w technologii Flutter, która umożliwia przeglądanie informacji o bohaterach gry Dota 2. Dane są pobierane z publicznego API OpenDota i prezentowane w przejrzystym interfejsie użytkownika.

Aplikacja pozwala na wyszukiwanie bohaterów, filtrowanie ich według głównego atrybutu, sortowanie listy, porównywanie statystyk dwóch bohaterów oraz przeglądanie szczegółowych informacji o wybranej postaci.

---

## Główne funkcjonalności

* Pobieranie listy bohaterów Dota 2 z API OpenDota
* Wyszukiwanie bohaterów po nazwie
* Filtrowanie bohaterów według atrybutu
* Sortowanie listy alfabetycznie
* Wyświetlanie szczegółowych informacji o bohaterze
* Porównywanie statystyk dwóch bohaterów
* Wyświetlanie najlepszych matchupów wybranego bohatera
* Obsługa zapytań REST API

---

## Wykorzystane technologie

* Flutter
* Dart
* OpenDota API
* Hive Database
* HTTP Package
* Material Design

---

## Architektura aplikacji

Projekt został podzielony na kilka warstw:

### Models

Modele danych wykorzystywane do mapowania odpowiedzi API.

* HeroModel
* MatchupModel

### Services

Warstwa odpowiedzialna za komunikację z API oraz lokalnym magazynem danych.

* ApiService
* DatabaseService

### Screens

* HeroListScreen
* HeroDetailScreen
* HeroCompareScreen

---

## Wykorzystane endpointy REST API

### Pobieranie listy bohaterów

GET

https://api.opendota.com/api/heroStats

Endpoint zwraca pełne statystyki wszystkich bohaterów.

### Pobieranie matchupów bohatera

GET

https://api.opendota.com/api/heroes/{id}/matchups

Endpoint zwraca statystyki matchupów dla wybranego bohatera.

---

## Przechowywanie danych

Aplikacja wykorzystuje bazę Hive do lokalnego przechowywania listy bohaterów. Dzięki temu użytkownik może przeglądać dane nawet w przypadku chwilowego braku połączenia z internetem.

---
