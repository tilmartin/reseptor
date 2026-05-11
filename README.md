# Reseptor

Statisk nettside for `reseptor.no`, strukturert for enkel drift på VPS nå og videre utvikling senere.

## Struktur

- `public/` inneholder filer som publiseres direkte på webserveren
- `deploy/nginx/` inneholder eksempel på Nginx-oppsett
- `scripts/` inneholder enkel deploy for VPS

## Anbefalt VPS-oppsett

Hold repo og publiserte filer adskilt:

```text
/srv/reseptor/repo        Git-klone
/var/www/reseptor/current Publiserte filer fra public/
```

Det gjør det enkelt å:

- oppdatere med `git pull`
- publisere med `./scripts/deploy.sh`
- rulle tilbake ved behov

## Første oppsett på VPS

```bash
sudo mkdir -p /srv/reseptor /var/www/reseptor/current
cd /srv/reseptor
git clone https://github.com/tilmartin/reseptor.git repo
cd repo
sudo ./scripts/deploy.sh
```

Legg deretter Nginx-konfigen fra `deploy/nginx/reseptor.no.conf` i:

```text
/etc/nginx/sites-available/reseptor.no.conf
```

Aktiver den og last Nginx på nytt:

```bash
sudo ln -s /etc/nginx/sites-available/reseptor.no.conf /etc/nginx/sites-enabled/reseptor.no.conf
sudo nginx -t
sudo systemctl reload nginx
```

Sett så opp TLS med Certbot eller tilsvarende på VPS-en.

## Oppdatering av nettsiden

På VPS:

```bash
cd /srv/reseptor/repo
git pull
sudo ./scripts/deploy.sh
sudo systemctl reload nginx
```

## Domene og DNS

For å få siden raskt opp igjen er det enklest å:

1. Hoste nettsiden på Hostinger VPS
2. La navnetjenere bli stående hos one.com og bare peke `reseptor.no` og `www.reseptor.no` til VPS-en
3. Beholde e-postposter uendret hvis dere fortsatt bruker Google Workspace

Hvis dere senere vil flytte selve domeneregistreringen også, kan det tas som et eget steg.
