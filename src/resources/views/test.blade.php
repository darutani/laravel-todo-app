<!doctype html>
<html lang="ja">

<head>
    <meta charset="utf-8">
    <title>test</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @vite(['resources/scss/app.css'])
</head>

<body>
    <h1 class="h1">これはテストです</h1>
</body>
</html>
