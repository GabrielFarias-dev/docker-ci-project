# Atividade Docker + CI — [SEU NOME]

**Aluno(a):** [nome completo]  **Turma:** [turma]  **Data:** [data]
**Aplicação usada:** docker/getting-started-app — To-Do em Node.js

## 1. Como executar este projeto
```bash
git clone git@github.com:GabrielFarias-dev/docker-ci-project.git
cd docker-ci-project
cp .env.example .env
docker compose up -d --build
```
Acesse: http://localhost:3000
Para derrubar: `docker compose down` (mantém dados) ou `docker compose down -v` (apaga dados).

## 2. Imagem e Dockerfile multi-stage
Estágios utilizados: `builder` (instala dependências com `npm ci`) e estágio final (copia apenas `node_modules` + `src`).
Imagem base: `node:20-alpine`
Usuário de execução: `node` (não-root)
Tamanho final da imagem: [preencher após `docker images`]
Por que o multi-stage ajuda? Ele separa as ferramentas/dependências de build da imagem final, deixando-a menor e sem artefatos desnecessários (cache de instalação, devDependencies etc.).

Print 1 — build + docker images
Print 2 — aplicação rodando com tarefas cadastradas

## 3. Volumes e persistência
Volume usado: `todo-db` → montado em `/etc/todos`
Print 3 — SEM volume: dados perdidos ao recriar o container
Print 4 — COM volume: dados preservados
Diferença entre `docker compose down` e `docker compose down -v`: [1 frase]

## 4. Rede
Rede criada: `todo-net`  Serviços conectados: [app e db]
A porta do banco está exposta ao host? Não — o banco só precisa ser acessado pelo serviço `app` dentro da rede interna do Compose, expô-lo ao host aumentaria a superfície de ataque sem necessidade.
Por que o app consegue chamar o host mysql/db sem saber o IP? [1 frase]
Print 5 — docker network inspect
Print 6 — dados dentro do MySQL (select * from todo_items;)

## 5. Docker Compose
Serviços: `app`, `db`  Rede: `todo-net` · Volume: `todo-mysql-data`
Healthcheck em: `db` · depends_on com: `condition: service_healthy`
Variáveis sensíveis: carregadas via `.env` (não versionado). Modelo em `.env.example`.
Print 7 — docker compose ps

## 6. Integração Contínua (GitHub Actions)
Arquivo do workflow: `.github/workflows/ci.yml`  Gatilhos: `push` e `pull_request`
O que o pipeline faz: checkout do código, cria `.env` a partir do `.env.example`, valida e builda o compose, sobe a stack, aguarda a aplicação responder, roda um smoke test de CRUD (`POST` + `GET /items`), imprime logs em caso de falha e sempre derruba a stack (`down -v`) ao final.
Print 8 — execução verde

## 7. Quebra proposital do CI
O que eu quebrei: [...]  Erro que apareceu no log: [...]
Como o CI reagiu: [...]  Como eu corrigi: [...]
Link do Pull Request: [URL]
Print 9 — execução vermelha + log do erro

## 8. Dificuldades e aprendizados
[3–5 linhas]

## 9. Checklist de autoavaliação
- [ ] Dockerfile multi-stage funcionando
- [ ] .dockerignore presente
- [ ] Container não roda como root
- [ ] Volume nomeado + persistência demonstrada
- [ ] Rede nomeada + banco não exposto ao host
- [ ] compose.yaml sobe tudo com um comando
- [ ] .env no .gitignore e .env.example versionado
- [ ] CI verde
- [ ] PR com CI vermelho documentado
- [ ] Todos os 9 prints no README
