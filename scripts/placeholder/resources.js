import { getRequest, postRequest, putRequest, patchRequest, deleteRequest } from '../../utils/requestMethods.js';
import { check, sleep } from 'k6';

const TESTS_TO_RUN = __ENV.TESTS ? __ENV.TESTS.split(',') : ['1', '2', '3', '4', '5', '6', '7', '8'];

export default function () {
  if (TESTS_TO_RUN.includes('1')) {
    let getRes = getRequest('https://jsonplaceholder.typicode.com/posts');
    check(getRes, { 'GET ENDPOINT: posts - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('2')) {
    let postRes = getRequest('https://jsonplaceholder.typicode.com/posts/1', JSON.stringify({ key: 'value' }));
    check(postRes, { 'GET ENDPOINT: posts/1 - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('3')) {
    let putRes = getRequest('https://jsonplaceholder.typicode.com/posts/1/comments', JSON.stringify({ key: 'updatedValue' }));
    check(putRes, { 'GET ENDPOINT: posts/1/comments - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('4')) {
    let patchRes = getRequest('https://jsonplaceholder.typicode.com/comments?postId=1', JSON.stringify({ key: 'patchedValue' }));
    check(patchRes, { 'GET ENDPOINT: comments?postId=1 - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('5')) {
    const payload = JSON.stringify({
      title: 'foo',
      body: 'bar',
      userId: 1,
    });

    const params = {
      headers: {
        'Content-Type': 'application/json',
      },
    };

    let postRes = postRequest('https://jsonplaceholder.typicode.com/posts', payload, params);
    check(postRes, { 'POST ENDPOINT: posts - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('6')) {
    const payload = JSON.stringify({
      id: 1,
      title: 'foo',
      body: 'bar',
      userId: 1,
    });

    const params = {
      headers: {
        'Content-Type': 'application/json',
      },
    };

    let postRes = putRequest('https://jsonplaceholder.typicode.com/posts/1', payload, params);
    check(postRes, { 'PUT ENDPOINT: posts - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('7')) {
    const payload = JSON.stringify({
      title: 'foo',
    });

    const params = {
      headers: {
        'Content-Type': 'application/json',
      },
    };

    let postRes = patchRequest('https://jsonplaceholder.typicode.com/posts/1', payload, params);
    check(postRes, { 'PATCH ENDPOINT: posts - status é 200': (r) => r.status === 200 });
  }

  if (TESTS_TO_RUN.includes('8')) {
    let deleteRes = deleteRequest('https://jsonplaceholder.typicode.com/posts/1');
    check(deleteRes, { 'DELETE ENDPOINT: posts - status é 200': (r) => r.status === 200 });
  }

  sleep(1);
}
