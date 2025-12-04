<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Slider Demo</title>
    {!! Minify::stylesheet(['../vendor/nickdekruijk/laravel-slider/src/assets/slider.css']) !!}
</head>
<body>

@include('slider::slider', ['id' => 'homepage'])

{!! Minify::javascript([
'https://cdn.jsdelivr.net/npm/vanilla-lazyload@17.5.1/dist/lazyload.min.js',
'../vendor/nickdekruijk/laravel-slider/src/assets/slider.js',
'slider-init.js'
]) !!}


</body>
</html>
