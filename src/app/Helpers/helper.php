<?php
declare(strict_types=1);

if (! function_exists('build_domain')) {
    /**
     * domainの文字列を構築
     *
     * @param string|null $subdomain
     * @return string
     */
    function build_domain(?string $subdomain = null): string
    {
        if (is_null($domain = env('APP_DOMAIN'))) {
            return 'localhost';
        }

        return ($subdomain) ? "{$subdomain}.{$domain}" : $domain;
    }
}
