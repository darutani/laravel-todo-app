@extends('layouts.app')

@section('title')
    {{--  --}}
@endsection

@section('js')
    @viteReactRefresh
    @vite([
        'resources/ts/index.tsx',
    ])
@endsection

@section('css')
    @vite([
        'resources/scss/app.scss',
    ])
@endsection

@section('content')
    <div id="app">
        @yield('page_content')
    </div>
@endsection
