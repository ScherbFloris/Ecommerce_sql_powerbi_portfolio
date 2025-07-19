
# 📋 Data Quality Checks (Olist Dataset)

## Ziel
Vor der Analyse wurden die Olist-Daten auf Konsistenz, Vollständigkeit und mögliche Fehlerquellen geprüft.

## Vorgehen
Die SQL-Abfragen wurden mit PostgreSQL (DBeaver) durchgeführt. Geprüft wurden unter anderem:

- Fehlende Werte
- Duplikate
- Ungültige Zeitstempel (z. B. Lieferung vor Bestellung)

| Tabelle                  | Beobachtung                        | Status     |
|--------------------------|-------------------------------------|------------|
| `olist_orders_dataset`   | Keine Duplikate, keine fehlenden IDs | ✅ OK      |
| `olist_customers_dataset`| Teilweise fehlende PLZ              | ⚠️ Offen   |
| `olist_products_dataset` | Sprachinkonsistenzen bei Kategorien | 🟡 In Prüfung |

> 💡 Die SQL-Abfragen findest du unter [`/sql/data_quality_checks.sql`](../sql/data_quality_checks.sql)

---

*Stand: 2025-07-19 · Floris Karl Scherb*
