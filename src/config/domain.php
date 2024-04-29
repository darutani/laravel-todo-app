<?php

return [

    'web' => build_domain(),
    'api' => build_domain(env('SUBDOMAIN_API')),
    'admin' => build_domain(env('SUBDOMAIN_ADMIN')),

];
