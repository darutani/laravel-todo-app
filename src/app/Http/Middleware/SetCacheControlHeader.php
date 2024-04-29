<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

/**
 * `Cache-Control`ヘッダを設定するmiddleware
 *
 * - NOTE: Laravel組み込みの実装にこれをしてくれるmiddlewareがすでにあるのですが、
 * 引数指定前提なこともあり、今後の開発でルートごとにキャッシュ設定が分岐した場合に
 * 実装設定が煩雑になる可能性があるため、自前でデフォルトをあてられるように実装しておきます。
 */
class SetCacheControlHeader
{
    /**
     * `Cache-Control`ヘッダのデフォルト設定
     *
     * @var string
     */
    private const DEFAULT_CACHE_CONTROL = 'private, no-store, no-cache, must-revalidate';

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        /** @var \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse */
        $response = $next($request);

        $response->headers->set('Cache-Control', self::DEFAULT_CACHE_CONTROL);

        return $response;
    }
}
