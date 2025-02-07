import http from 'k6/http';

// GET Request
export function getRequest(url, params = {}) {
  return http.get(url, params);
}

// POST Request
export function postRequest(url, payload, params = {}) {
  return http.post(url, payload, {
    headers: { 'Content-Type': 'application/json' },
    ...params,
  });
}

// PUT Request
export function putRequest(url, payload, params = {}) {
  return http.put(url, payload, {
    headers: { 'Content-Type': 'application/json' },
    ...params,
  });
}

// PATCH Request
export function patchRequest(url, payload, params = {}) {
  return http.patch(url, payload, {
    headers: { 'Content-Type': 'application/json' },
    ...params,
  });
}

// DELETE Request
export function deleteRequest(url, params = {}) {
  return http.del(url, params);
}
