<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SliderController extends Controller
{
    public function show()
    {
        return view('slider.index');
    }
}
