<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SliderController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/slider', [SliderController::class, 'show']);
