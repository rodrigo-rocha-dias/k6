export const options = {
    vus: 500, // Número de usuários simultâneos
    duration: '5m', // Duração do teste
    thresholds: {
      http_req_duration: ['p(95)<2000'], // 95% das requisições devem ser menores que 2s
      http_req_failed: ['rate<0.01'], // Menos de 1% de falhas permitidas
    },
  };