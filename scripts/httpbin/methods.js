import { getRequest, postRequest, putRequest, patchRequest, deleteRequest } from '../../utils/requestMethods.js';
import { check, sleep } from 'k6';

const TESTS_TO_RUN = __ENV.TESTS ? __ENV.TESTS.split(',') : ['1', '2', '3', '4', '5'];

export default function () {
  if (TESTS_TO_RUN.includes('1')) {
    let getRes = getRequest('https://httpbin.org/get');
    check(getRes, { 'GET - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('2')) {
    let postRes = postRequest('https://httpbin.org/post', JSON.stringify({ key: 'value' }));
    check(postRes, { 'POST - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('3')) {
    let putRes = putRequest('https://httpbin.org/put', JSON.stringify({ key: 'updatedValue' }));
    check(putRes, { 'PUT - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('4')) {
    let patchRes = patchRequest('https://httpbin.org/patch', JSON.stringify({ key: 'patchedValue' }));
    check(patchRes, { 'PATCH - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('5')) {
    let deleteRes = deleteRequest('https://httpbin.org/delete');
    check(deleteRes, { 'DELETE - status é 200': (r) => r.status === 200 });
  }

  sleep(1);
}
