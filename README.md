# Biometrie Onderzoek

**Auteurs:** Jesse Postma (507655), Robin Offringa (468620), Tristan Kruithof (508757)

---

## Inleiding

Al jaren lang is er vraag naar onderzoek naar de verhouding van armlengte tot lichaamslengte bij mannen en vrouwen. In dit project geven wij antwoord op dit vraagstuk aan de hand van eigen metingen en statistische analyses.

---

## Onderzoeksvraag

Is er een verschil tussen de verhouding van armlengte tot lichaamslengte bij mannen en vrouwen?

---

## Hypothese

Er is een verschil tussen de verhouding van armlengte tot lichaamslengte bij mannen en vrouwen.

## NulHypothese

Er is geen verschil tussen de verhouding van armlengte tot lichaamslengte bij mannen en vrouwen.

---

## Ontwerp van het experiment

### Wat meten we?

We meten de lichaamslengte en de armlengte van elk persoon, afgerond op hele centimeters.

### Welke groepen?

We meten mannen en vrouwen als afzonderlijke groepen.

### Hoeveel metingen?

We maken 20 metingen per groep, dus 40 samples in totaal.

---

## Protocol voor meting armlengte en lichaamslengte

Om te garanderen dat verschillende onderzoekers de metingen op dezelfde reproduceerbare manier uitvoeren, is de uitvoering van het experiment vastgelegd in een protocol.

### Benodigdheden

1. Schuifmaat of meetlint.
2. Spreadsheet om resultaten vast te leggen, met toegang hiertoe op locaties zonder internet-toegang.
3. Je laborant-ID: een unieke *identifier* die jou als onderzoeker identificeert. Neem hiervoor je studentnummer.

### Data verzamelen

Zoek, samen met een ander groepje van je klas, in of rond het schoolgebouw medestudenten die willen deelnemen aan het onderzoek. Leg kort uit dat jullie voor een schoolopdracht de armlengte en lichaamslengte meten en dat alle gegevens anoniem worden opgeslagen.

- Is het antwoord **nee**, bedank dan vriendelijk en zoek verder.
- Is het antwoord **ja**, wijs dan de proefpersoon een rustige plek aan waar de meting kan plaatsvinden.

Vraag de proefpersoon om:

1. **Lichaamslengte:** Rechtop te gaan staan tegen een muur of meetlat, met hakken tegen de grond. Meet de lichaamslengte in centimeters en noteer deze in de spreadsheet.
2. **Armlengte:** De arm zijwaarts te strekken op schouderhoogte. Meet de armlengte van het schouderpunt (acromion) tot de pols (carpal bot pisiform), opnieuw in centimeters.

Leg beide waarden vast in de spreadsheet, samen met:

- je laborant-ID,
- een subject-ID (géén naam),
- de sexe van de proefpersoon (m/v/anders/onbekend).

Het parallelle groepje voert dezelfde metingen uit bij dezelfde proefpersonen, zonder jullie resultaten te horen, en gebruikt daarbij dezelfde subject-ID's.

Bedank de proefpersoon voor deelname. Wissel de metingen af tussen de laboranten in jullie groepje om meetfouten te verminderen.

Ga door totdat er voldoende gegevens zijn verzameld voor beide doelgroepen.

---

## Dataformaat

Sla de onderzoeksresultaten op in de volgende vorm:

```
gender;lengte;l arm;meter;Id
m; 190; 54; 507655; 2
m; 191; 54; 507656; 2
<meer rijen met data>
```

---

## Analyse

### Data inlezen

Gebruik het volgende R-codeblok om de data vanuit een tekstbestand in te lezen:

```r
data_file <- "pad/naar/meten.csv"

# data format: gender;lengte;l arm;meter;Id
res_data <- read.table(file = data_file,
                       header = TRUE,
                       sep = ";")
```

### Beschrijvende statistiek

Bereken de lengte/armlengte-ratio en bekijk de eerste rijen:

```r
res_data$ratio <- res_data$lengte / res_data$"l.arm"
head(res_data)
```

Bereken gemiddelde lengte, armlengte en ratio per gender:

```r
gender_split_data <- split(x = res_data, f = res_data$gender)
sapply(X = gender_split_data,
       FUN = function(x){
         c(length = mean(x$lengte),
           arm    = mean(x$l.arm),
           ratio  = mean(x$ratio),
           dev    = sd(x$ratio))
       })
```

### Visualisaties

```r
library(ggplot2)

# Boxplot armlengte per gender
ggplot(data = res_data,
       mapping = aes(x = gender, y = l.arm, fill = gender)) +
    geom_boxplot() +
    labs(x = "Gender", y = "Arm length (cm)") +
    theme_minimal()

# Boxplot lichaamslengte per gender
ggplot(data = res_data,
       mapping = aes(x = gender, y = lengte, fill = gender)) +
    geom_boxplot() +
    geom_point() +
    labs(x = "Gender", y = "Lengte (cm)") +
    theme_minimal()

# Boxplot ratio per gender
ggplot(data = res_data,
       mapping = aes(x = gender, y = ratio, fill = gender)) +
    geom_boxplot() +
    geom_point() +
    labs(x = "Gender", y = "Ratio lengte/armlengte") +
    theme_minimal()
```

### Welke verdeling?

Experimenteer met de steekproefgrootte en het aantal bins om te ontdekken wanneer een normaalverdeling zichtbaar wordt:

```r
hist_data <- data.frame(x = rnorm(n = 100))
ggplot(data = hist_data,
       mapping = aes(x = x)) +
    geom_histogram(bins = 10, fill = "gold", colour = "black") +
    theme_minimal()
```

**Vragen om te beantwoorden:**

1. Wat gebeurt er met de vorm van de verdeling als `n` groter wordt?
2. Wat gebeurt er met de spreiding van de data (x-as) als `n` groter wordt, en kan je dat verklaren?
3. Waarom is bij dezelfde instellingen voor `n` en `breaks` de uitkomst toch verschillend?
4. Welke minimale `n` geeft het meeste kans om een echte normaalverdeling te zien?
5. Wat voor bijzonders is er aan de hand met het `breaks`-argument? Geeft de documentatie daar een verklaring voor?

### Bronnen van variatie

Bespreek en onderzoek de bronnen van variatie in de metingen (bijv. meetfouten tussen laboranten, subjectieve interpretatie van meetpunten).

### De hypothese aannemen?

Voer relevante statistische toetsen uit (bijv. t-toets of Wilcoxon-toets) om te bepalen of de nulhypothese verworpen kan worden.

---

## Reflectie op het experiment

Bespreek in je groep de volgende vragen:

1. Zijn de metingen tussen de verschillende meters ook (significant) verschillend? Zo ja, waardoor zou je de verschillen kunnen verklaren?
2. Onderzoek de verschillen tussen mannen en vrouwen met betrekking tot handlengte, handbreedte en de ratio.
3. Zou je het protocol aanpassen na deze ervaring, of was hij voldoende duidelijk en reproduceerbaar?

---

## Projectstructuur

| Bestand | Beschrijving |
|---|---|
| `README.md` | Projectbeschrijving (dit bestand) |
| `meten.csv` | Verzamelde meetdata |
| `analyse.Rmd` | RMarkdown-document met volledige analyse |

---

## Vereisten

- [R](https://www.r-project.org/) (>= 4.0)
- R-pakket: `ggplot2`

Installeer het pakket met:

```r
install.packages("ggplot2")
```