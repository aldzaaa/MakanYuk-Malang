// Server kontrak demo lokal; bukan proxy Google Places dan tidak memakai secret.
import { createServer } from 'node:http';
import { readFile } from 'node:fs/promises';
import { pathToFileURL } from 'node:url';

export async function createDemoServer() {
  const data = JSON.parse(await readFile(new URL('../assets/data/culinary_seed.json', import.meta.url), 'utf8'));
  return createServer((req, res) => {
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    res.setHeader('Cache-Control', 'no-store');
    const origin = req.headers.origin;
    if (origin && /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origin)) {
      res.setHeader('Access-Control-Allow-Origin', origin);
      res.setHeader('Vary', 'Origin');
    }
    const send = (code, body) => {res.writeHead(code); res.end(JSON.stringify(body));};
    const url = new URL(req.url, 'http://localhost');
    if (req.method !== 'GET') return send(405, {error:'Gunakan GET'});
    if (url.pathname !== '/api/v1/culinary') return send(404, {error:'Endpoint tidak ditemukan'});
    const category = url.searchParams.get('category') ?? 'all';
    const limit = Number(url.searchParams.get('limit') ?? '20');
    if (!Number.isInteger(limit) || limit < 1 || limit > 20 || !['all', ...data.map(p => p.category)].includes(category)) {
      return send(400, {error:'Parameter tidak valid'});
    }
    send(200, {data:data.filter(p => category === 'all' || p.category === category).slice(0,limit), source:'demo', isDemo:true});
  });
}
if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  (await createDemoServer()).listen(8787, '127.0.0.1', () => console.log('API demo: http://127.0.0.1:8787/api/v1/culinary'));
}