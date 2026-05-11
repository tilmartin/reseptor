# DNS cutover for reseptor.no

Bruk one.com kun som DNS-leverandør under flyttingen. Ikke bytt nameservere hvis målet bare er å peke nettsiden til VPS-en.

## Nåværende oppsett

- `reseptor.no` peker i dag til Netlify-relaterte A-poster
- `www.reseptor.no` er i dag en CNAME til Netlify
- E-post bruker Google MX-poster

## Når VPS-en er klar

Bytt bare web-relaterte DNS-poster:

### A-record for rotdomenet

- Hostname: tomt felt
- Type: `A`
- Value: `VPS_IPV4`
- TTL: `600` under flytting, eventuelt `3600` etterpå

Fjern gamle A-poster for rotdomenet som peker til tidligere webhosting.

### WWW-record

Velg én av disse:

1. Anbefalt:
   - Hostname: `www`
   - Type: `CNAME`
   - Value: `reseptor.no`
2. Alternativ:
   - Hostname: `www`
   - Type: `A`
   - Value: `VPS_IPV4`

Fjern gammel `www`-record som peker til Netlify.

### IPv6

Hvis VPS-en har en offentlig IPv6-adresse, legg også inn:

- Hostname: tomt felt
- Type: `AAAA`
- Value: `VPS_IPV6`

Og eventuelt samme for `www` hvis dere ikke bruker CNAME.

## Ikke rør disse postene

La disse stå urørt hvis dere fortsatt bruker Google Workspace:

- `MX`
- `TXT` for Google-verifisering
- eventuelle SPF, DKIM eller DMARC-poster

## Verifisering etter endring

Kjør disse:

```bash
dig reseptor.no A
dig www.reseptor.no
curl -I http://reseptor.no
curl -I https://reseptor.no
```

## Kjent gammel web-DNS som skal bort

Disse bør fjernes når VPS-en tar over webtrafikken:

- `75.2.60.5`
- `99.83.190.102`
- `76.76.21.21`
- `www -> incredible-dasik-ad8e9e.netlify.app`
