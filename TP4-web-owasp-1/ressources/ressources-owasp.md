# Ressources OWASP (libres et gratuites)

Pour réviser et aller plus loin que le TP. Tout est **gratuit** et maintenu par l'OWASP Foundation
ou des projets ouverts.

## Comprendre

- **OWASP Top 10 (édition 2025)** — les dix catégories de risque d'une application web, notre fil
  rouge : <https://owasp.org/Top10/>
- **OWASP Juice Shop** — l'application volontairement vulnérable du TP (projet OWASP, licence MIT) :
  <https://owasp.org/www-project-juice-shop/>

## Se défendre (côté développeur — l'essentiel pour l'examen)

- **OWASP Cheat Sheet Series** — une fiche par sujet, les parades concrètes :
  <https://cheatsheetseries.owasp.org/>
  - *SQL Injection Prevention* (requêtes paramétrées) :
    <https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html>
  - *Cross Site Scripting Prevention* (output encoding) :
    <https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html>
  - *Input Validation* :
    <https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html>

## S'entraîner (à la maison)

- **PortSwigger Web Security Academy** — labos interactifs gratuits (les auteurs de Burp Suite),
  excellents pour SQL injection et XSS : <https://portswigger.net/web-security>

> Un guide officiel de solutions pour Juice Shop existe (*Pwning OWASP Juice Shop*). Il **donne les
> réponses** des défis : à garder pour **après** avoir cherché par vous-même, sinon le TP ne sert à rien.

## Rappel vocabulaire (examen)

**Risque = Menace × Vulnérabilité × Impact.** L'OWASP Top 10, ce sont dix **catégories de risque** ;
chacune regroupe des *weaknesses* (faiblesses de code, catalogue **CWE**). SQL injection (CWE-89) et
XSS (CWE-79) vivent toutes deux dans **A05 Injection**.
