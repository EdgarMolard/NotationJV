# Ygrec

Base de projet full-stack avec:
- Frontend React (Vite)
- Backend Express (TypeScript)
- Base de donnees PostgreSQL
- Docker Compose uniquement pour la base de donnees

## Prerequis

- Node.js 20+
- npm
- Docker
- Docker Compose

## Installation

1. Installer les dependances a la racine et dans les deux apps:

```bash
npm install
npm --prefix backend install
npm --prefix frontend install
```

2. Copier les variables d'environnement:

```bash
cp .env.example .env
```

Générer une clé pour le JWT_SECRET dans le .env
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

## Lancer la base PostgreSQL (Docker)

```bash
npm run db:up
```

Au premier lancement (volume vide), PostgreSQL importe automatiquement le dump SQL versionne dans:

```text
database/init/001_init.sql
```

Cela permet d'avoir des donnees de demo directement apres le premier build du projet.

Arret de la base:

```bash
npm run db:down
```

Reinitialiser la base (supprime le volume Docker puis reimporte le dump):

```bash
npm run db:reset
```

## Lancer le frontend + backend en local

Commande unique:

```bash
npm run dev
```

Cette commande lance:
- backend sur http://localhost:3000
- frontend sur http://localhost:5173

## Verification rapide

- Backend health: http://localhost:3000/health
- Frontend: page de connexion React

## Arborescence

```text
.
├── backend
│   ├── Dockerfile
│   ├── package.json
│   ├── tsconfig.json
│   └── src
│       └── index.ts
├── frontend
│   ├── Dockerfile
│   ├── index.html
│   ├── package.json
│   ├── vite.config.js
│   └── src
│       ├── App.jsx
│       ├── main.jsx
│       └── styles.css
├── .env.example
├── .gitignore
├── docker-compose.yml
└── package.json
```

## Connexion bdd

docker compose exec db psql -U postgres -d ygrec

## Regenerer le dump SQL de demo

Si tu modifies les donnees et que tu veux mettre a jour le dump fourni au projet:

```bash
mkdir -p database/init
docker compose exec -T db sh -lc 'pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" --clean --if-exists --no-owner --no-privileges --inserts --column-inserts' > database/init/001_init.sql
```