<!doctype html>
<html lang="ja">

<head>
    <meta charset="utf-8">
    <title>test</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @vite(['resources/scss/app.scss'])
</head>

<body>
    <h1 class="test">これはテストです</h1>
    <h2 class="test">h2です。</h2>
</body>
</html>
