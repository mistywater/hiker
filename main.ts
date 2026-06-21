export default { 
  async fetch(request: Request) { 
    const url = new URL(request.url); 
    const targetUrl = url.pathname.substring(1) + url.search; 
 
    // 格式校验 
    if (!targetUrl || (!targetUrl.startsWith('http://') && !targetUrl.startsWith('https://'))) { 
      return new Response('Usage: https://your-domain.deno.dev/https://target-url.com', { status: 400 }); 
    } 
 
    try { 
      // 转发请求：完整透传方法/头/body，自动跟随跳转 
      const response = await fetch(targetUrl, { 
        method: request.method, 
        headers: request.headers, 
        body: request.body, 
        redirect: 'follow' 
      }); 
 
      // 复制原始响应头，添加完整CORS跨域头，不限制域名 
      const newHeaders = new Headers(response.headers); 
      newHeaders.set('Access-Control-Allow-Origin', '*'); 
      newHeaders.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'); 
      newHeaders.set('Access-Control-Allow-Headers', '*'); 
 
      // 处理OPTIONS预检请求，避免跨域预检失败 
      if (request.method === 'OPTIONS') { 
        return new Response(null, { 
          status: 204, 
          headers: newHeaders 
        }); 
      } 
 
      // 返回处理后的响应 
      return new Response(response.body, { 
        status: response.status, 
        headers: newHeaders 
      }); 
    } catch (e: any) { 
      // 错误响应也添加CORS头，避免被浏览器拦截 
      const errorHeaders = new Headers(); 
      errorHeaders.set('Access-Control-Allow-Origin', '*'); 
      return new Response(`Fetch failed: ${e.message}`, { 
        status: 500, 
        headers: errorHeaders 
      }); 
    } 
  } 
}; 
