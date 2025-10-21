# 📱 sa_somativo – App de Registro de Ponto com Geolocalização e Biometria

> **Avaliação Somativa em Desenvolvimento Mobile com Flutter**  
> Um aplicativo que permite ao funcionário **registrar seu ponto de trabalho apenas quando estiver a até 100 metros do local de trabalho**, com autenticação segura e histórico completo com localizações.

---

## 🎯 Objetivos

- Autenticar usuários via **NIF (CPF) + senha** ou **biometria** (Touch ID / Face ID).
- Validar a **localização do usuário em tempo real**.
- Permitir o registro de ponto **somente dentro de um raio de 100 metros** do local de trabalho.
- Armazenar registros com **data, hora e coordenadas geográficas** no **Firebase Firestore**.
- Exibir um **histórico completo** com status (válido/inválido) e localizações visíveis.

---

## 🧩 Funcionalidades Implementadas

| Recurso | Tecnologia |
|--------|-----------|
| Login com NIF/senha | Firebase Authentication |
| Login com biometria | `local_auth` |
| Verificação de localização | `geolocator` |
| Cálculo de distância (≤100m) | `Geolocator.distanceBetween()` |
| Registro de ponto | Cloud Firestore |
| Histórico em tempo real | `StreamBuilder` + Firestore |
| Exibição de coordenadas | Latitude e longitude com 5 casas decimais |
| Interface responsiva | Flutter Material 3 |

---

## 🗺️ Diagrama de Fluxo (Mermaid)

```mermaid
%%{init: {'theme': 'base', 'themeVariables': { 'fontSize': '14px'}}}%%
graph TD
    A[App de Registro de Ponto] --> B[Login Screen]
    B --> C{Autenticação}
    C -->|NIF + Senha| D[Firebase Auth]
    C -->|Biometria| E[Local Auth Plugin]
    D --> F[Home Screen]
    E --> F
    F --> G[Registrar Ponto]
    G --> H[Verificar Localização]
    H --> I{Dentro de 100m?}
    I -->|Sim| J[Salvar no Firestore]
    I -->|Não| K[Exibir: Fora do Raio]
    J --> L[Histórico Atualizado em Tempo Real]
    K --> G
    F --> M[Ver Histórico]
    M --> N[Exibir Data, Hora e Localização]