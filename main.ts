export default {
  async fetch(request: Request) {
    const url = new URL(request.url);
    const targetUrl = url.pathname.substring(1) + url.search;
 
    if (!targetUrl || (!targetUrl.startsWith('http://') && !targetUrl.startsWith('https://'))) {
      return new Response('Usage: https://your-domain.deno.dev/https://target-url.com', { status: 400 });
    }
 
    try {
      const response = await fetch(targetUrl, {
        method: request.method,
        headers: request.headers,
        body: request.body,
        redirect: 'follow'
      });
      const newHeaders = new Headers(response.headers);
      newHeaders.set('Access-Control-Allow-Origin', '*');
      return new Response(response.body, {
        status: response.status,
        headers: newHeaders 
      });
    } catch (e: any) {
      return new Response('Fetch failed: ' + e.message, { status: 500 });
    }
  }
};
