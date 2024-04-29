<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="format-detection" content="telephone=no">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <link rel="shortcut icon" href={{ asset('/favicon.ico') }} />

        <title>@yield('title') || {{ config('app.name', 'Laravel') }} </title>

        @yield('js')
        @yield('css')
    </head>

    <body>
        @yield('content')
    </body>

</html>
