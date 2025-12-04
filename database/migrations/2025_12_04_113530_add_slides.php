<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;


return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::table('slides')->insert(
            array(
                'active' => 1,
                'title' => 'Title slide 1',
                'head' => 'HEAD 1',
                'images' => 'slide1.jpg',
                'classes' => 'custom-class-1',
                'text' => 'text 1',
            )
        );
        DB::table('slides')->insert(
            array(
                'active' => 1,
                'title' => 'Title slide 2',
                'head' => 'HEAD 2',
                'images' => 'slide2.jpg',
                'classes' => 'custom-class-2',
                'text' => 'text 2',
            )
        );
        DB::table('slides')->insert(
            array(
                'active' => 1,
                'title' => 'Title slide 3',
                'head' => 'HEAD 3',
                'images' => 'slide3.jpg',
                'classes' => 'custom-class-3',
                'text' => 'text 3',
            )
        );
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
