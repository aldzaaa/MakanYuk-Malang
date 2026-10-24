import { test } from 'node:test';
import assert from 'node:assert/strict';
import { createDemoServer } from './demo_api.mjs';

test('Server API nyata memberi JSON demo, filter, limit, dan menolak parameter salah', async () => {
  const server = await createDemoServer();
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  try {
    const base = `http://127.0.0.1:${server.address().port}`;
    const response = await fetch(`${base}/api/v1/culinary?category=Bakso&limit=1`, {headers:{Origin:'http://localhost:5210'}});
    assert.equal(response.status, 200);
    const body = await response.json();
    assert.equal(body.isDemo, true);
    assert.equal(body.data.length, 1);
    assert.equal(body.data[0].category, 'Bakso');
    assert.equal(response.headers.get('access-control-allow-origin'), 'http://localhost:5210');
    assert.equal((await fetch(`${base}/api/v1/culinary?limit=100`)).status, 400);
    assert.equal((await fetch(`${base}/api/v1/culinary?category=unknown`)).status, 400);
    assert.equal((await fetch(`${base}/missing`)).status, 404);
  } finally { await new Promise(resolve => server.close(resolve)); }
});