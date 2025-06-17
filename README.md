# 🛍️ Segmentation de clients pour Olist (marketplace e-commerce brésilienne)

**Projet 5 – Mastère Spécialisé Data Science – OpenClassrooms**  
**Rôle : Data Scientist**  
**Client : Olist (Marketplace e-commerce, Brésil)**

---

## 🎯 Objectif du projet

Olist souhaite disposer d’une **segmentation client opérationnelle** pour orienter ses campagnes marketing. En parallèle, un **contrat de maintenance** est envisagé, avec une fréquence de mise à jour à proposer.

### Missions principales :
- Implémenter des requêtes SQL pour alimenter un dashboard Customer Experience
- Réaliser une segmentation client actionable
- Évaluer la stabilité de la segmentation dans le temps
- Recommander une fréquence de mise à jour

---

## 🗂️ Données exploitées

Les données proviennent de [Kaggle - Olist Brazilian E-commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
Elles couvrent la période **2016 à 2018** et incluent 9 fichiers `.csv` contenant :
- Commandes, paiements, livraisons
- Données produits, vendeurs, clients
- Géolocalisation, retours satisfaction

---

## ⚙️ Partie 1 – Requêtes SQL pour le dashboard CX

#### ✔️ Requêtes implémentées :
1. Commandes livrées avec >3 jours de retard (hors annulées, <3 mois)
2. Vendeurs ayant généré >100K R$ de CA
3. Nouveaux vendeurs (–3 mois) avec >30 ventes
4. Top 5 codes postaux avec mauvaise note moyenne (sur 12 mois)

---

## 🧪 Partie 2 – Segmentation client

### 🔍 Analyse exploratoire
- Requêtes SQL + fusion des fichiers
- Nettoyage : commandes livrées uniquement
- Focus sur comportement d’achat, satisfaction et localisation

### 📦 Approche RFM (Recency, Frequency, Monetary)
- Variables standardisées
- Visualisation des segments
- TreeMap et nuages de points pour interpréter

### 🤖 Clustering non supervisé
- **KMeans** : test de `k = 3` et `k = 4`
- **DBSCAN** : `eps = 0.2` et `0.4` (inefficace)

🧠 **Meilleur modèle : KMeans avec `k=4`**, qui produit des segments cohérents :
- `Cluster 0` : Clients à réactiver  
- `Cluster 1` : Nouveaux / potentiels fidèles  
- `Cluster 2` : Clients perdus  
- `Cluster 3` : Loyaux / champions

📊 Visualisation des clusters en 2D par **ACP**

---

## 🛠️ Partie 3 – Contrat de maintenance

- Étude de la **stabilité des clusters** via le **score ARI (Adjusted Rand Index)**
- Données de 2017 utilisées pour entraîner le modèle
- Mise à jour simulée chaque semaine sur données 2018
- 📉 ARI < 0.7 après 13 semaines

🔁 **Fréquence recommandée de re-segmentation** : **chaque trimestre**

---

## 📁 Livrables

- 📜 script SQL pour le dashboard CX
- 📓 exploration et préparation des données
- 📓 essais RFM + clustering
- 📓 simulation ARI dans le temps
- 🖥️ Support de présentation

---

## 🛠️ Compétences mobilisées

- Requêtes SQL avancées pour analyse client
- Segmentation par RFM
- Apprentissage non supervisé (KMeans, DBSCAN)
- Réduction de dimension (ACP)
- Simulation de stabilité de modèles dans le temps (ARI)

---

## 🙋‍♂️ Réalisé par

**Maodo FALL**  
*Data Scientist*  

---
