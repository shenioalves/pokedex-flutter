# 🧩 Pokedex Flutter App

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?style=flat&logo=dart&logoColor=white)
![State Management](https://img.shields.io/badge/State-BLoC%20%26%20Cubit-purple?style=flat)
![Architecture](https://img.shields.io/badge/Arch-Clean-green?style=flat)

Aplicativo desenvolvido em Flutter com foco em **arquitetura limpa, performance e UI moderna**, consumindo a [PokéAPI](https://pokeapi.co/).

O projeto demonstra o uso avançado de gerenciamento de estado, injeção de dependência e persistência local de dados.

---

## 📱 Screenshots

| Home (Lista) | Filtros Dinâmicos | Detalhes | Favoritos |
|:---:|:---:|:---:|:---:|
| | | | |
| ![Home](https://via.placeholder.com/150?text=Home) | ![Filter](https://via.placeholder.com/150?text=Filtros) | ![Details](https://via.placeholder.com/150?text=Detalhes) | ![Favs](https://via.placeholder.com/150?text=Favoritos) |

---

## 🚀 Funcionalidades

### 🔍 Navegação e Busca
- **Listagem Infinita**: Scroll infinito com paginação automática (Lazy Loading) para alta performance.
- **Busca Inteligente**: Pesquisa por nome em tempo real com *debounce*.
- **Filtros por Tipo**: Filtragem dinâmica que altera o tema visual do app conforme o elemento (Fogo, Água, Planta, etc).
- **Splash Screen**: Tela de inicialização animada.

### ⭐ Favoritos Offline
- **Persistência de Dados**: Salva seus Pokémons favoritos localmente usando `shared_preferences`.
- **Sincronização**: A lista de favoritos é atualizada em tempo real em todas as telas via `Cubit`.

### 🎨 UI/UX Imersiva
- **Design Moderno**: Uso de sombras coloridas ("Glow"), Glassmorphism e Cards flutuantes.
- **Cores Adaptativas**: A interface muda de cor baseada no tipo do Pokémon selecionado.
- **Animações**: Transições `Hero` fluidas entre lista e detalhes.
- **Cache de Imagens**: Otimização de rede e performance usando `cached_network_image`.

---

## 🧱 Arquitetura do Projeto

O projeto segue uma estrutura modular baseada em funcionalidades (**Feature-First**), separando configurações, núcleo e regras de negócio.

```bash
lib/
└── app/
    ├── config/           # Configurações globais
    │   ├── routes/       # Definição de rotas (GoRouter)
    │   └── locator_config.dart # Injeção de Dependências (GetIt)
    ├── core/             # Núcleo compartilhado
    │   ├── api/          # Cliente HTTP (Dio) e interceptors
    │   └── utils/        # Funções utilitárias e constantes
    ├── features/         # Módulos do aplicativo
    │   ├── favorites/    # Feature de Favoritos (Lógica Offline e UI)
    │   ├── pokedex/      # Feature Principal (Lista, Filtros e Busca)
    │   └── splash/       # Tela de Abertura
    ├── model/            # Modelos de dados globais e Mappers
    └── theme/            # Design System (Cores e Estilos)

## 🛠️ Tecnologias e Bibliotecas

    flutter_bloc: Gerenciamento de estado robusto (Padrão BLoC e Cubit).

    dio: Cliente HTTP potente para requisições API.

    get_it: Injeção de Dependência (Service Locator).

    go_router: Navegação declarativa baseada em rotas e URLs.

    shared_preferences: Persistência de dados local (Favoritos).

    cached_network_image: Cache inteligente de imagens.

    equatable: Comparação de objetos para otimizar rebuilds.

##⚡ Como rodar o projeto

    Clone o repositório

```bash
git clone [https://github.com/seu-usuario/pokedex-flutter.git](https://github.com/seu-usuario/pokedex-flutter.git)
cd pokedex-flutter

Instale as dependências
```bash

flutter pub get

Execute o aplicativo
```bash

    flutter run

🚧 Roadmap (Próximos Passos)

    [ ] Implementar Testes Unitários e de Widget (Bloc Test).

    [ ] Adicionar suporte a Dark Mode.

    [ ] Criar gráfico de estatísticas (Radar Chart) na tela de detalhes.

    [ ] Adicionar filtros avançados (Peso, Altura).

## 👨‍💻 Autor

Desenvolvido por Shênio de Souza Alves Projeto criado para demonstrar domínio em Flutter, Arquitetura Limpa e Boas Práticas de Desenvolvimento.