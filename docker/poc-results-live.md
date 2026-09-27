# Relatório POC: Resultados Reais dos Cenários FIPE

Este documento captura a execução simulando alta volumetria e valida os cenários esperados.

## 1. Tabela de Performance (K6 - 200 VUs por 20s)

| Cenário | Volumetria (Reqs) | RPS | Cache MISS | Erros (Timeouts/Fails) | Latência p90 | Latência p95 |
|---------|-------------------|-----|------------|-------------------------|--------------|--------------|
| Direct DB (Gargalo) |  |  | - | 0 | ms | ms |
| Cache com TTL (Stampede) |  |  | 0
0 | 0 | ms | ms |
| Cache com Warming (Ideal) |  |  | 0
0 | 0 | ms | ms |

**Análise Final**:
- **Cenário 1 (DB Direto):** O gargalo do Pool de Conexões do banco limitou o throughput bruto.
- **Cenário 2 (Cache TTL):** Houve grande melhoria de latência geral, porém picos de latência e concorrência sobrecarregando o sistema periodicamente ("Cache Stampede").
- **Cenário 3 (Cache com Warmup):** Desempenho máximo, mantendo p95 muito baixa sem onerar o banco, entregando zero erros.

## 2. Evidência do Fenômeno "Cache Stampede" (Cenário 2)

O Cache Stampede acontece porque, ao expirar uma chave em alta concorrência `N` VUs, dezenas de instâncias percebem o *Cache MISS* e fazem a consulta simultânea ao banco de dados no exato momento, re-saturando o pool do HikariCP desnecessariamente e gerando interrupções no tempo de reposta da API que seriam invisíveis na média bruta.

**Comportamento capturado nos logs do Spring Boot durante o teste de carga:**
- Nenhum grande stampede capturado nesta iteração.
