import { getRequest, postRequest, putRequest, patchRequest, deleteRequest } from '../../utils/requestMethods.js';
import { check, sleep } from 'k6';

const TESTS_TO_RUN = __ENV.TESTS ? __ENV.TESTS.split(',') : ['1', '2', '3', '4'];

export default function () {
  if (TESTS_TO_RUN.includes('1')) {
    let getRes = getRequest('www.blazedemo.com/');
    check(getRes, { 'GET - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('2')) {
    let postRes = postRequest('www.blazedemo.com/reserve.php', JSON.stringify({ key: 'value' }));
    check(postRes, { 'POST - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('3')) {
    let putRes = postRequest('www.blazedemo.com/purchase.php', JSON.stringify({ key: 'updatedValue' }));
    check(putRes, { 'POST - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('4')) {
    let patchRes = postRequest('www.blazedemo.com/confirmation.php', JSON.stringify({ key: 'patchedValue' }));
    check(patchRes, { 'POST - status é 200': (r) => r.status === 200 });
  }

  sleep(1);
}
