export default { 
  async fetch(request: Request) { 
    const url = new URL(request.url); 
    
    // 1. 提取目标 URL，修复双斜杠被压缩的问题 
    let targetUrl = url.pathname.substring(1) + url.search; 
    targetUrl = targetUrl.replace(/^https?:\/+/i, (match) => match.includes('s') ? 'https://' : 'http://');
 
    // 格式校验 
    if (!targetUrl || (!targetUrl.startsWith('http://') && !targetUrl.startsWith('https://'))) { 
      return new Response('Usage: https://your-domain.deno.dev/https://target-url.com', { status: 400 }); 
    } 
 
    // 处理 OPTIONS 预检请求 
    if (request.method === 'OPTIONS') { 
      const corsHeaders = new Headers();
      corsHeaders.set('Access-Control-Allow-Origin', '*'); 
      corsHeaders.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'); 
      corsHeaders.set('Access-Control-Allow-Headers', '*'); 
      corsHeaders.set('Access-Control-Max-Age', '86400'); 
      return new Response(null, { status: 204, headers: corsHeaders }); 
    } 
 
    try { 
      // 2. 清理不该透传的头，尤其是 Host 和 Content-Length 
      const reqHeaders = new Headers(request.headers);
      reqHeaders.delete('host');
      reqHeaders.delete('connection');
      reqHeaders.delete('content-length'); // 必须删！让 fetch 根据新的 body 自动计算 
      reqHeaders.delete('origin');
      reqHeaders.delete('referer');
 
      // 3. 提前读取 Body（因为 request.body 是 Stream，只能读一次，且重定向时需要重新发送）
      let body = null;
      if (request.method !== 'GET' && request.method !== 'HEAD') {
        body = await request.arrayBuffer(); 
      }
 
      // 4. 发起请求，设置 redirect: 'manual' 不自动跟随重定向 
      let response = await fetch(targetUrl, { 
        method: request.method, 
        headers: reqHeaders, 
        body: body, 
        redirect: 'manual' // ⭐ 关键：拦截自动重定向 
      }); 
 
      // 5. 手动处理重定向，强制保持 POST 方法 
      if ([301, 302, 303, 307, 308].includes(response.status)) {
        const location = response.headers.get('location');
        if (location) {
          const newUrl = new URL(location, targetUrl).href; // 解析重定向的真实地址 
          // 用原始的 Method 和 Body 再次请求，防止 POST 变 GET 
          response = await fetch(newUrl, { 
            method: request.method, 
            headers: reqHeaders, 
            body: body, 
            redirect: 'follow' // 第二次允许自动跟随（通常不会无限跳）
          }); 
        }
      }
 
      // 6. 复制响应头，添加 CORS 
      const respHeaders = new Headers(response.headers); 
      respHeaders.set('Access-Control-Allow-Origin', '*'); 
      respHeaders.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'); 
      respHeaders.set('Access-Control-Allow-Headers', '*'); 
 
      return new Response(response.body, { 
        status: response.status, 
        headers: respHeaders 
      }); 
    } catch (e: any) { 
      const errorHeaders = new Headers(); 
      errorHeaders.set('Access-Control-Allow-Origin', '*'); 
      return new Response(`Fetch failed: ${e.message}`, { 
        status: 500, 
        headers: errorHeaders 
      }); 
    } 
  } 
};
