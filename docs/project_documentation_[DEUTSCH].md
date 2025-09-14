
# Projektdokumentation Olist Datensatz

## Inhaltsverzeichnis
- [1. Kurzvorstellung Olist](#1-kurzvorstellung-olist)
- [2. Datensatzbeschreibung](#2-datensatzbeschreibung)

## 1. Kurzvorstellung Olist

Olist ist ein brasilianisches E-Commerce-Unternehmen, das als Marktplatzplattform für kleine und mittelständische Händler fungiert. 
Anstatt selbst Waren zu verkaufen, ermöglicht Olist externen Händlern, ihre Produkte über ihren Online-Markttplatz anzubieten. 
Olist übernimmt dabei zentrale Aufgaben wie Produktlistung, Marketing, Zahlungsabwicklung, Logistik und Kundenservice. 
Für Händler entsteht dadurch ein vereinfachter Zugang zum brasilianischen Online-Handel.

## 2. Datensatzbeschreibung

**Quelle:**  
Der Datensatz stammt von [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) und wurde von Olist zur Verfügung gestellt.  

**Größe:**  
- 9 Tabellen  
- > 100.000 Bestellungen (Zeitraum: 2016–2018)  
- mehrere Millionen Zeilen insgesamt  

**Datenbereiche:**  
- **Bestellungen** (Auftrags-IDs, Zeitstempel, Status)  
- **Produkte** (Kategorie, Preis, Maße, Gewicht)  
- **Kunden & Geodaten** (PLZ, Stadt, Bundesstaat)  

**Eignung des Datensatzes:**  
Der Olist-Datensatz ist für Analyse- und BI-Projekte besonders geeignet, da er:  
- **umfangreich** ist mit einer umfangreich großen Datenmenge,  
- **realistische Geschäftsprozesse** eines Online-Marktplatzes abbildet,  
- **vielfältige Dimensionen** enthält (Zeit, Region, Produkt, Kunde, Umsatz),  
- und sich daher ideal für **SQL-Datenmodellierung** sowie die **Erstellung interaktiver Dashboards** eignet.

## 3. Problemidentifikation & Zielsetzung

Die reinen Rohdaten von Olist sind umfangreich, aber für Stakeholder schwer direkt zu interpretieren.  
Besonders für Entscheidungsträger in Marketing und Produktmanagement fehlen schnelle und visuelle Zugänge zu zentralen Fragestellungen.  
Um datenbasierte Entscheidungen treffen zu können, müssen die Daten aufbereitet und in verständlicher Form dargestellt werden.

### Zentrale Business-Fragen*
1. **Wie entwickeln sich Umsatz, Bestellungen und der durchschnittliche Bestellwert über die Zeit?**  
2. **Welche Produkte und Kategorien sind die Haupttreiber von Umsatz und Bestellungen?**  
3. **In welchen Städten und Regionen konzentriert sich die Nachfrage am stärksten?**

### Abgeleitete Dashboards
Um diese Fragen zu beantworten, wurden drei Dashboards entwickelt:

| Problem | Ziel | Dashboard | Wichtige KPIs |
|---------|------|-----------|---------------|
| Kein Überblick über Umsatz- und Bestellentwicklung | Entwicklung von Umsatz, Bestellungen und Durchschnittlicher Bestellwert (AOV) sichtbar machen | **Sales Overview Dashboard** | Revenue, Orders, AOV, Wachstumsraten (MoM/YoY) |
| Unklare Performance von Produktkategorien | Umsatztreiber und Potenziale identifizieren | **Product Analysis Dashboard** | Umsatz je Kategorie, Orders je Kategorie, AOV, Top-Produkte |
| Unklare regionale Nachfrage-Hotspots | Wichtigste Städte/Regionen für Umsatz hervorheben | **Regional Demand Dashboard (Hotspots)** | Umsatz nach Stadt, Umsatzanteile, Orders, AOV |

# * Dieses Projekt konzentriert sich auf den Zeitraum 2017, da dies das einzige vollständige Jahr im Datensatz ist.

## 4. Methodik / Vorgehen

### 4.1 Datenaufbereitung in SQL

### 4.2 Datenmodellierung & Transformation in in PowerBI

## 5. Ergebnisse (Dashboards)

### 5.1 Sales Overiew Dashboard

### 5.2 Product Analysis Dashboard

### 5.3 Regional Hotspot Analysis

# 6. Empfehlugnen

# 7. Ausblick



